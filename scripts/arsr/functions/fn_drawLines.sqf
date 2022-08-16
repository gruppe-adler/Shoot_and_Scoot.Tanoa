params ["_originatorPos", "_inAccurateOriginalPos", "_interceptPos", "", "", "_maxRange"];
private _marker = call arsr_fnc_initMarker;
_marker setMarkerColorLocal arsr_lineColor;
_marker setMarkerShapeLocal "polyline";

private _polyLine = [];
{
    _polyLine pushBack (_x select 0);
    _polyLine pushBack (_x select 1);
} forEach [_interceptPos, _interceptPos getPos [_maxRange, (_interceptPos getDir _inAccurateOriginalPos)]];

_marker setMarkerPolylineLocal _polyLine;
