params ["_originatorPos", "_inAccurateOriginalPos", "_interceptPos", "", "_accuracy", "_maxRange"];
private _marker = call arsr_fnc_initMarker;
_marker setMarkerColorLocal arsr_lineColor;
_marker setMarkerShapeLocal "polyline";

private _dir = _interceptPos getDir _inAccurateOriginalPos;
private _vector1 = vectorNormalized (_interceptPos vectorFromTo (_inAccurateOriginalPos getPos [_accuracy/2, _dir + 90]));
private _vector2 = vectorNormalized (_interceptPos vectorFromTo (_inAccurateOriginalPos getPos [_accuracy/2, _dir - 90]));

private _polyLine = [];
{
    _polyLine pushBack (_x select 0);
    _polyLine pushBack (_x select 1);
} forEach [
    _interceptPos,
    _interceptPos vectorAdd (_vector1 vectorMultiply _maxRange),
    _interceptPos vectorAdd (_vector2 vectorMultiply _maxRange),
    _interceptPos
];

_marker setMarkerPolylineLocal _polyLine;
