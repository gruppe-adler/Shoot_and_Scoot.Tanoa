if (isServer) then {
    craters_indirectHitRangeCache = createHashMap;
    getTerrainInfo params ["", "", "_cellSize"];
    craters_cellSize = _cellSize;
    addMissionEventHandler ["ProjectileCreated", {
        params ["_projectile"];
        _projectile addEventHandler ["Explode", {_this call craters_fnc_deform;}];
    }];
};

if !(hasInterface) exitWith {};

["craters_create", {
    params ["_posASL", "_indirectHitRAnge"];

    private _boom = createSimpleObject ["Land_DirtPatch_03_F", _posASL, true];
    _boom setPosASL _posASL;
    _boom setDir random 360;
    _boom setObjectScale (_indirectHitRAnge / 20);
    private _grassCutter = "Land_ClutterCutter_large_F" createVehicleLocal _posASL;
    _grassCutter setPosASL _posASL;
    _grassCutter enableSimulation false;
}] call CBA_fnc_addEventHandler;
