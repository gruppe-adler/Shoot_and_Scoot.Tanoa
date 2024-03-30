params ["_originatorPos", ["_artySide", sideLogic], ["_radioCall", false]];
private _time = time;

// Check if a vehicle has at least one crew member alive
// Returns true if at least one crew member is alive, false otherwise
// @param vehicleObject: Object - The vehicle to check
// @return Boolean
fnc_listenerOperatorNearby = {
    
    private _aliveCrew = (crew _this) select { alive _x };
    private _numAliveCrew = count _aliveCrew;
    
    is_Zeus = !isNull (getAssignedCuratorLogic player);    // check if current player is a Zeus
    if (is_Zeus) then { systemChat (str(_this) + " _numAliveCrew=" + str(_numAliveCrew)) }; // debug message
    
    _numAliveCrew > 0
};


{
    private _distance =  _x distance _originatorPos;
    private _soundDelay = 0;
    if (!_radioCall && arsr_speedOfSound > 0) then {
        _soundDelay = _distance / arsr_speedOfSound;
    };

    [{
        params [["_originatorPos", [0, 0, 0]], ["_vic", objNull], ["_time", 0], ["_radioCall", false]];
        if !(alive _vic) exitWith {};
        if (arsr_vicStationary && {(speed _vic) isNotEqualTo 0}) exitWith {};
        if (arsr_vicEngineOff && {isEngineOn _vic}) exitWith {};
        if ((_originatorPos distance _vic) > (_vic getVariable ["arsr_listenerMaxDistance", arsr_listenerMaxDistance])) exitWith {};

        private _angleError = _vic getVariable ["arsr_angleError", arsr_angleError];
        private _preciseHeading   = (getPos _vic getDir _originatorPos) + 360;    // adding 360° prevents from dealing with negative numbers
        private _falseHeading     = (random [_preciseHeading-_angleError, _preciseHeading, _preciseHeading+_angleError]) % 360;    // precise heading plus a gaussian distributed error added to it
        // systemChat format ["_preciseHeading=%1, _falseHeading=%2, _angleError=%3", _preciseHeading % 360, _falseHeading, _angleError];

        [{
            params ["_originatorPos", "_falseHeading", "_interceptPos", "_vic", "_interceptTime", "_radioCall"];
            if !(alive _vic) exitWith {};
            private _targets = ([] call CBA_fnc_players) select {
                side _x == independent || { // streamers shall see all bearings
                _x getVariable ["arsr_receptionAllowed", false] && { // can receive in general
                alive _x && { // is alive
                ((_vic getVariable ["arsr_side", sideLogic]) isEqualTo sideLogic || {(side group _x) isEqualTo (_vic getVariable ["arsr_side", sideLogic])}) // check if listener has a side assigned and if it matches the receiver units side
            }}}};

            // send drawing event with all information necessary to paint on the map
            ["arsr_drawData", [
                _originatorPos,
                _falseHeading,
                _interceptPos, // position of listener
                side _vic, // side of listener
                _radioCall, // true if TFAR emission was intercepted
                _vic getVariable ["arsr_angleError", arsr_angleError],
                _vic getVariable ["arsr_listenerMaxDistance", arsr_listenerMaxDistance]
            ], _targets] call CBA_fnc_targetEvent;
        },[
            _originatorPos, // precise position of artillery
            _falseHeading, // precise heading with some random error added to it
            getPos _vic, // position of listener at the time fire was heard
            _vic, // the listener itself
            _time, // time when artillery fired
            _radioCall  // true if TFAR emission was intercepted
        ], _vic getVariable ["arsr_listenerCalcDelay", arsr_listenerCalcDelay]] call CBA_fnc_waitAndExecute;

    }, [_originatorPos, _x, _time, _radioCall], _soundDelay] call CBA_fnc_waitAndExecute;
} foreach (arsr_listeners select {
    ((_x getVariable ["tf_range",0]) == 50000) && { // listener is actively listening
    (_artySide isNotEqualTo (_x getVariable ["arsr_side", sideLogic])) && { // check if the firing vehicle is not on the same side as the listener
    (_x call fnc_listenerOperatorNearby) // listener station has an operator nearby
}}});
