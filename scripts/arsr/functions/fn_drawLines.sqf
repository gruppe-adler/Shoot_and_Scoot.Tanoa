params ["_originatorPos", "_angleError", "_interceptPos", "", "", "_maxRange"];
private _marker = call arsr_fnc_initMarker;
_marker setMarkerColorLocal arsr_lineColor;
_marker setMarkerShapeLocal "polyline";

private _preciseHeading   = (_interceptPos getDir _originatorPos) + 360;    // adding 360° prevents from dealing with negative numbers
private _falseHeading     = (random [_preciseHeading-_angleError, _preciseHeading, _preciseHeading+_angleError]) % 360;    // precise heading plus a gaussian distributed error added to it
// systemChat format ["_preciseHeading=%1, _falseHeading=%2, _angleError=%3", _preciseHeading % 360, _falseHeading, _angleError];

private _from = _interceptPos;
private _to   = _interceptPos getPos [_maxRange, _falseHeading];

private _polyLine = [];
{
    _polyLine pushBack (_x select 0);
    _polyLine pushBack (_x select 1);
} forEach [_from, _to];

_marker setMarkerPolylineLocal _polyLine;
