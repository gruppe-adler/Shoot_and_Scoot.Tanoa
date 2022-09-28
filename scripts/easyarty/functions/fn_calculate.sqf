params ["_targetPos", "_vehicle"];

#define DEGREE_TO_MIL_FACTOR 17.7777777778

private _az = (_vehicle getDir _targetPos) * DEGREE_TO_MIL_FACTOR;

private _distanceToTarget = _vehicle distance artyTarget;
private _distanceRounded = _distanceToTarget - _distanceToTarget % 100;
private _distanceFactor = _distanceToTarget % 100 * -0.01; //used to scale later

(ace_artillerytables_magModeData select ace_artillerytables_lastCharge) params [["_muzzleVelocity", -1], ["_airFriction", 0]];
private _elevMin = 10;
private _elevMax = 75;
private _lastElevMode = param [0, ace_artillerytables_lastElevationMode];
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

if (_distanceToTarget > _maxResult || {_distanceToTarget < _minResult}) exitWith { [] };

private _idxLower = (_distanceRounded - _minResult) / 100; 
private _idxUpper = (_distanceRounded + 100 - _minResult) / 100;

private _lSolution = _result select _idxLower;
private _uSolution = _result select _idxUpper;

private _diffElevation = parseNumber (_lSolution select 1) - parseNumber (_uSolution select 1);
private _finalElevation = parseNumber (_lSolution select 1) + _diffElevation * _distanceFactor;

[_finalElevation, _az, _distanceToTarget];