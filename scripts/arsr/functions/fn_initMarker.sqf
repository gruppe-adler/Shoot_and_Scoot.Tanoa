params ["_originatorPos", "", "_interceptPos"];
// We delete pre existing markers
private _markerName = format ["_USER_DEFINED%1%2%3", _originatorPos, _interceptPos, time];
deleteMarkerLocal _markerName;
// We allow the user to delete the marker
private _marker = createMarkerLocal [_markerName, _interceptPos];

if (arsr_autoDeleteMarkerTime >= 0) then {
    [{
        deleteMarkerLocal _this;
    }, _marker, arsr_autoDeleteMarkerTime] call CBA_fnc_waitAndExecute;
};

_marker
