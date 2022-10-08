if !(hasinterface) exitWith {};

easyarty_running = false;
easyarty_pfh = -1;
easyarty_displayEh = -1;

private _spacerAction = [
    "easyarty_spacer",
    "Easy Arty",
    "",
    {},
    {[player, "ACE_artilleryTable"] call BIS_fnc_hasItem}
] call ace_interact_menu_fnc_createAction;

private _startAction = [
    "easyarty_start",
    "Start calculate",
    "",
    {[] spawn easyarty_fnc_start;},
    {!easyarty_running}    
] call ace_interact_menu_fnc_createAction;

private _stopAction = [
    "easyarty_stop",
    "Stop calculation",
    "",
    {[] call easyarty_fnc_stop;},
    {easyarty_running}    
] call ace_interact_menu_fnc_createAction;

private _newTargetAction = [
    "easyarty_newTarget",
    "Assign new target",
    "",
    {[] spawn easyarty_fnc_setTargetPos;},
    {easyarty_running}    
] call ace_interact_menu_fnc_createAction;

[
    "Man",
    1,
    ["ACE_SelfActions"],
    _spacerAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
    "Man",
    1,
    ["ACE_SelfActions", "easyarty_spacer"],
    _startAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
    "Man",
    1,
    ["ACE_SelfActions", "easyarty_spacer"],
    _stopAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
    "Man",
    1,
    ["ACE_SelfActions", "easyarty_spacer"],
    _newTargetAction,
    true
] call ace_interact_menu_fnc_addActionToClass;
