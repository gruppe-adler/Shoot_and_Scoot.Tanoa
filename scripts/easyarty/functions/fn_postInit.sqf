if (isDedicated) exitWith {};
easyArtyRunning = false;
easyArtyPfh = -1;
easyArtyDisplayEh = -1;

private _spacerAction = [
    "spacerEasyArty",
    "Easy Arty",
    "",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

private _startAction = [
    "startEasyArty",
    "Start calculate",
    "",
    {[] spawn easyarty_fnc_start;},
    {!easyArtyRunning}    
] call ace_interact_menu_fnc_createAction;

private _stopAction = [
    "stopEasyArty",
    "Stop calculation",
    "",
    {[] call easyarty_fnc_stop;},
    {easyArtyRunning}    
] call ace_interact_menu_fnc_createAction;

private _assignPosAction = [
    "assingPosEasyArty",
    "Assign new target",
    "",
    {[] spawn easyarty_fnc_setTargetPos;},
    {easyArtyRunning}    
] call ace_interact_menu_fnc_createAction;

[
    player,
    1,
    ["ACE_SelfActions"],
    _spacerAction
] call ace_interact_menu_fnc_addActionToObject;

[
    player,
    1,
    ["ACE_SelfActions", "spacerEasyArty"],
    _startAction
] call ace_interact_menu_fnc_addActionToObject;

[
    player,
    1,
    ["ACE_SelfActions", "spacerEasyArty"],
    _stopAction
] call ace_interact_menu_fnc_addActionToObject;

[
    player,
    1,
    ["ACE_SelfActions", "spacerEasyArty"],
    _assignPosAction
] call ace_interact_menu_fnc_addActionToObject;