params ["_originatorPos", "_falseHeading", "_interceptPos", "_side", "_radioCall", "_angleError", "_maxRange"];
private _marker = call arsr_fnc_initMarker;

if (_radioCall) then {
    _marker setMarkerColorLocal "ColorBlack";
} else {
    _marker setMarkerColorLocal ([_side,  true] call BIS_fnc_sideColor);
};
_marker setMarkerShapeLocal "polyline";

private _from = _interceptPos;
private _to   = _interceptPos getPos [_maxRange, _falseHeading];

private _polyLine = [];
{
    _polyLine pushBack (_x select 0);
    _polyLine pushBack (_x select 1);
} forEach [_from, _to];

_marker setMarkerPolylineLocal _polyLine;
