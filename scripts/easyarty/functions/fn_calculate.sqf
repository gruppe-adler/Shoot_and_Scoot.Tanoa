params ["_targetPos", "_vehicle"];

#define DEGREE_TO_MIL_FACTOR 17.7777777778

private _az = (_vehicle getDir _targetPos) * DEGREE_TO_MIL_FACTOR;

private _deltaDistance = _vehicle distance2d _targetPos;
private _distanceRounded = _deltaDistance - _deltaDistance % 100;
private _distanceFactor = _deltaDistance % 100 * 0.01;
private _heightFactor = ((getPosASL _vehicle select 2) - getTerrainHeightASL _targetPos) / 100 * -1;

(ace_artillerytables_magModeData select ace_artillerytables_lastCharge) params [["_muzzleVelocity", -1], ["_airFriction", 0]];
private _elevMin = 10;
private _elevMax = 75;
private _lastElevMode = ace_artillerytables_lastElevationMode;
private _ret = "ace_artillerytables" callExtension ["start", [_muzzleVelocity,_airFriction,_elevMin,_elevMax,_lastElevMode]];
private _status = 0;
private _result = [];

while { _status != 3 } do {
    _ret = ("ace_artillerytables" callExtension ["getline", []]);
    _status = _ret select 1;
	if (_status == 1) then {
	    _result pushBack parseSimpleArray (_ret select 0);
	};
};

private _resultLength = count _result;

if (_resultLength < 3) exitWith {[]};

private _minResult = parseNumber (_result select 0 select 0);
private _maxResult = parseNumber (_result select _resultLength-1 select 0);

if (_deltaDistance > _maxResult || {_deltaDistance < _minResult}) exitWith { [] };

private _idxLower = (_distanceRounded - _minResult) / 100; 
private _idxUpper = (_distanceRounded + 100 - _minResult) / 100;

private _lSolution = _result select _idxLower;
private _uSolution = _result select _idxUpper;

private _diffElevation = parseNumber (_lSolution select 1) - parseNumber (_uSolution select 1);
private _hightOffset = _lSolution select 2;
_hightOffset = [1, parseNumber _hightOffset] select (_hightOffset isNotEqualTo "-");

private _tof = _lSolution select 4;

// in high mode less elevation is father, in low it is the opposite.
// in high mode we subtract to gain range, in low mode we need to add
// because - * a negative number (see diff calc) is like adding, this works for both cases
private _finalElevation = parseNumber (_lSolution select 1) - _diffElevation * _distanceFactor - _hightOffset * _heightFactor;

[_finalElevation, _az, _deltaDistance, _tof];