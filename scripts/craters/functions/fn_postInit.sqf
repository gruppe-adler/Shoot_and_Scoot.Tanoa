if (isServer) then {
    craters_indirectHitRangeCache = createHashMap;
    // craters_queueHash = createHashMap;
    getTerrainInfo params ["", "", "_cellSize"];
    craters_cellSize = _cellSize;
    addMissionEventHandler ["ProjectileCreated", {
        params ["_projectile"];
        _projectile addEventHandler ["Explode", {_this call craters_fnc_deform;}];
    }];
    ["ace_explosives_place", {
        params ["_explosive"];
        _explosive addEventHandler ["Explode", {_this call craters_fnc_deform;}];
    }] call CBA_fnc_addEventHandler;
};

if !(hasInterface) exitWith {};

["craters_create", {
    params ["_posASL", "_indirectHitRAnge"];

    private _boom = createSimpleObject ["Land_DirtPatch_03_F", _posASL, true];
    _boom setPosASL _posASL;
    _boom setDir random 360;
    _boom setObjectScale (_indirectHitRAnge / 20);
    private _objectArray = [];
    private _grassCutter = "Land_ClutterCutter_large_F" createVehicleLocal _posASL;
    _objectArray pushBack _grassCutter;
    _grassCutter setPosASL _posASL;
    _grassCutter enableSimulation false;
    if (_indirectHitRange > 31) then {
        private _posAGL = ASLToAGL _posASL;
        for "_outer" from 1 to ((_indirectHitRAnge / 4) / 10) do {
            private _objects = floor 6 * _outer;
            for "_i" from 1 to _objects do {
                private _newPos = _posAGL getPos [10 * _outer, (360 / _objects)*_i];
                _grassCutter = "Land_ClutterCutter_large_F" createVehicleLocal _newPos;
                _grassCutter setPos _newPos;
                _grassCutter enableSimulation false;
                _objectArray pushBack _grassCutter;
            };
        };
    };
    [{
        {
            deleteVehicle _x;
        } forEach _this;
    }, _objectArray, 15*60] call CBA_fnc_waitAndExecute
}] call CBA_fnc_addEventHandler;
