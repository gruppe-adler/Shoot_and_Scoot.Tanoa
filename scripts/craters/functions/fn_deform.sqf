params ["_projectile", "_posASL"];
if (craters_sizeCoef <= 0) exitWith {};
private _type = typeOf _projectile;
private _indirectHitRange = craters_indirectHitRangeCache getOrDefault [_type, -1];
if (_indirectHitRange < 0) then {
    _indirectHitRange = getNumber (configFile >> "CfgAmmo" >> _type >> "indirectHitRange");
    craters_indirectHitRangeCache set [_type, _indirectHitRange];
};

if (_indirectHitRange < 10 || {((getPosATL _projectile) select 2) > 0.25}) exitWith {};
_indirectHitRange = _indirectHitRange * craters_sizeCoef;
private _heightDiff = linearConversion [10, 35, _indirectHitRange, 0, -1, false];
private _terrainDeform = [_posASL vectorAdd [0, 0, _heightDiff]];
if (_heightDiff <= -1) then {
    private _horizontalDiff = _indirectHitRange/4;
    _terrainDeform = [];

    for "_xDif" from -(_horizontalDiff) to _horizontalDiff step craters_cellSize do {
        for "_yDif" from -(_horizontalDiff) to _horizontalDiff step craters_cellSize do {
            private _newHeight = _heightDiff * (linearConversion [0, _horizontalDiff, abs _yDif, 1, 0, true]) * (linearConversion [0, _horizontalDiff, abs _xDif, 1, 0, true]);
            if (_newHeight < -0.25) then {
                private _newPos = _posASL vectorAdd [_xDif, _yDif, 0];
                _newPos set [2, (getTerrainHeight _newPos) + _newHeight];
                _terrainDeform pushBack _newPos;
            };
        };
    };
};

setTerrainHeight [_terrainDeform, true];

["craters_create", [_posASL, _indirectHitRange]] call CBA_fnc_globalEvent;
