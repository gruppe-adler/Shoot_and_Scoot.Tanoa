params ["_seat", "_player", ["_seatPos", 0]];

_player setVariable ["ace_sitting_sittingStatus", [_seat, -1, _seatPos]];
private _sitPositionAll = diw_stomper_sitPosition;
// Prevent multiple people sitting on one seat
private _seatsClaimed = _seat getVariable ["ace_sitting_seatsClaimed", []];
// Initialize claimed seats if first time sitting on it
if (_seatsClaimed isEqualTo []) then {
    for "_i" from 0 to ((count _sitPositionAll) - 1) do {
        _seatsClaimed pushBack (_i == _seatPos);
    };
} else {
    _seatsClaimed set [_seatPos, true];
};
_seat setVariable ["ace_sitting_seatsClaimed", _seatsClaimed, true];

// private _virtSeat = "vurtual_seat" createVehicleLocal [0,0,0];
private _virtSeat = "vurtual_seat" createVehicle [0,0,0];
(_sitPositionAll select _seatPos) params [["_pos", [0,0,0]], ["_dir", 0]];
_virtSeat attachTo [_seat, _pos];
_virtSeat setDir _dir;
_virtSeat setVariable ["stomper", _seat];
_virtSeat setVariable ["seatPos", _seatPos];
_virtSeat animateSource ["seat_hide",1];

_virtSeat hideSelection ["seat_hid", false];
_virtSeat hideSelection ["proxy:\a3\data_f\proxies\passenger_low01\cargo01.001", true];

_virtSeat addEventHandler ["GetOut", {
    params ["_vehicle", "_role", "_unit", "_turret"];
    private _stomper = _vehicle getVariable ["stomper", objNull];
    private _seatPos = _vehicle getVariable ["seatPos", 0];
    // Allow sitting on this seat again
    private _seatsClaimed = _stomper getVariable ["ace_sitting_seatsClaimed", []];
    _seatsClaimed set [_seatPos, false];
    _stomper setVariable ["ace_sitting_seatsClaimed", _seatsClaimed, true];
    _unit setVariable ["ace_sitting_sittingStatus", nil];
    detach _vehicle;
    deleteVehicle _vehicle;
}];

_player moveInCargo _virtSeat;
