if !(hasInterface) exitWith {};

if !(isClass (configFile >> "CfgVehicles" >> "vurtual_seat")) exitWith {
    systemChat "Stomper sitting script could not initialize, missing mods: ""vurtual's Car Seat & Stretcher""";
};

diw_stomper_sitPosition = [
    [[-0.4,1.1,0.3], -90],
    [[-0.4,0.6,0.3], -90],
    [[-0.4,0.1,0.3], -90],
    [[-0.4,-0.4,0.3], -90],
    [[-0.4,-0.9,0.3], -90],
    [[-0.3,-1.4,0.35], -90],
    [[0.5,-1.95,0.35], 180],
    [[1.15,-1.5,0.35], 90],
    [[1.2,-0.9,0.3], 90],
    [[1.2,-0.4,0.3], 90],
    [[1.2,0.1,0.3], 90],
    [[0.45,-0.55,0.3]]
];

{
    // Exit if class already initialized
    private _type = _x;
    if (_type in ace_sitting_initializedClasses) then {
        continue;
    };
    ace_sitting_initializedClasses pushBack _type;

    private _interactPosition = [
        [-0.4,1.1,-0.7],
        [-0.4,0.6,-0.7],
        [-0.4,0.1,-0.7],
        [-0.4,-0.4,-0.7],
        [-0.4,-0.9,-0.7],
        [-0.3,-1.4,-0.65],
        [0.5,-1.95,-0.65],
        [1.15,-1.5,-0.65],
        [1.2,-0.9,-0.7],
        [1.2,-0.4,-0.7],
        [1.2,0.1,-0.7],
        [0.45,-0.55,-0.7]
    ];

    {
        private _menuPosition = [0,0,0];
        private _menuType = ["ACE_MainActions"];
        if (count _interactPosition >= _forEachIndex) then {
            _menuPosition = _interactPosition select _forEachIndex;
            _menuType = [];
        };

        private _sitAction = [
            format ["acex_sitting_Sit_%1", _forEachIndex],
            "Sit on stomper",
            "\z\ace\addons\sitting\UI\sit_ca.paa",
            {_this call stomper_fnc_sit},
            {_this call ace_sitting_fnc_canSit},
            {},
            _forEachIndex,
            _menuPosition,
            2.5	// distance to show sitting menu point
        ] call ace_interact_menu_fnc_createAction;
        [_type, 0, _menuType, _sitAction] call ace_interact_menu_fnc_addActionToClass;
    } forEach diw_stomper_sitPosition;
} forEach ["B_UGV_01_F", "O_UGV_01_F", "I_UGV_01_F", "B_T_UGV_01_olive_F", "O_T_UGV_01_ghex_F"];
