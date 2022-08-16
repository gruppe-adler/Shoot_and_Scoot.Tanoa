params ["_originatorPos", ["_artySide", sideLogic]];
private _time = time;

{
    private _distance =  _x distance _originatorPos;
    private _soundDelay = if (arsr_speedOfSound > 0) then {
        _distance / arsr_speedOfSound
    } else {
        0
    };
    [{
        params [["_originatorPos", [0, 0, 0]], ["_vic", objNull], ["_time", 0]];
        if !(alive _vic) exitWith {};
        if (arsr_vicStationary && {(speed _vic) isNotEqualTo 0}) exitWith {};
        if (arsr_vicEngineOff && {isEngineOn _vic}) exitWith {};
        if ((_originatorPos distance _vic) > (_vic getVariable ["arsr_listenerMaxDistance", arsr_listenerMaxDistance])) exitWith {};

        private _accuracy = _vic getVariable ["arsr_listenerAccuracy", arsr_listenerAccuracy];
        private _inAccurateOriginalPos = _originatorPos getPos [(_accuracy / 2) - (random _accuracy), random 360];

        [{
            params ["_originatorPos", "_inAccurateOriginalPos", "_interceptPos", "_vic", "_interceptTime"];
            if !(alive _vic) exitWith {};
            private _targets = ([] call CBA_fnc_players) select {
                _x getVariable ["arsr_receptionAllowed", false] && { // can receive in general
                alive _x && { // is alive
                ((_vic getVariable ["arsr_side", sideLogic]) isEqualTo sideLogic || {(side group _x) isEqualTo (_vic getVariable ["arsr_side", sideLogic])}) // check if listener has a side assigned and if it matches the receiver units side
            }}};
            ["arsr_drawData", [
                _originatorPos,
                _inAccurateOriginalPos,
                _interceptPos, // position of listener
                format ["%1#%2", _originatorPos, _interceptTime],
                _vic getVariable ["arsr_listenerAccuracy", arsr_listenerAccuracy],
                _vic getVariable ["arsr_listenerMaxDistance", arsr_listenerMaxDistance]
            ], _targets] call CBA_fnc_targetEvent;
        },[
            _originatorPos, // pricise position of artillery
            _inAccurateOriginalPos, // in accurate position of artillery
            getPos _vic, // position of listener at the time fire was heard
            _vic, // the listener itself
            _time // time when artillery fired
        ], _vic getVariable ["arsr_listenerCalcDelay", arsr_listenerCalcDelay]] call CBA_fnc_waitAndExecute;

    }, [_originatorPos, _x, _time], _soundDelay] call CBA_fnc_waitAndExecute;
} foreach (arsr_listeners select {
    _x getVariable ["arsr_enabled", true] && { // listener is actively listening
    // check if the firing vehicle is not on the same side as the listener
    (_artySide isNotEqualTo (_x getVariable ["arsr_side", sideLogic]))
}});
