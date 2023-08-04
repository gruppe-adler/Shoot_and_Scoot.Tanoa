if !(hasInterface) exitWith {};
// _this === station container

// add menu entry that allows putting a damaged camo net back up
// Vanilla HoldAction
[
    _this, // Object the action is attached to
    "Fix camouflage net", // Title of the action
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Idle icon shown on screen
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Progress icon shown on screen
    "_this distance _target < 15 && damage (_target getVariable 'shootnscoot_stationNet') > 0.9", // Condition for the action to be shown
    "_caller distance _target < 15", // Condition for the action to progress
    {}, // Code executed when action starts
    {}, // Code executed on every progress tick
    {
        (_target getVariable "shootnscoot_stationNet") setDamage 0.8
    }, // Code executed on completion
    {}, // Code executed on interrupted
    [], // Arguments passed to the scripts as _this select 3
    10, // action duration in seconds
    0, // priority
    false, // Remove on completion
    false// Show in unconscious state
] call BIS_fnc_holdActionAdd;

/*
 * ACE Progress Bar
 * Finish/Failure/Conditional are all passed [_args, _elapsedTime, _totalTime, _errorCode]
 * 0: Total Time (in game "time" seconds) <NUMBER>
 * 1: Arguments, passed to condition, fail and finish <ARRAY>
 * 2: On Finish: Code called or STRING raised as event. <CODE, STRING>
 * 3: On Failure: Code called or STRING raised as event. <CODE, STRING>
 * 4: (Optional) Localized Title <STRING>
 * 5: Code to check each frame (Optional) <CODE>
 * 6: Exceptions for checking EFUNC(common,canInteractWith) (Optional)<ARRAY>
*/
private _pbar = {[
    10,
    _this#0,
    {
        (_this#0 getVariable "shootnscoot_stationNet") setDamage 0.8;
    },
    {
    },
    "Repairing...",
    {
        alive player and (player distance _this#0) < 15 &&
        isNull objectParent player &&
        speed(_this#0) < 3
    }
] call ace_common_fnc_progressBar;
};
/*
 * ACE INTERACT
 * Argument:
 * 0: Action name <STRING>
 * 1: Name of the action shown in the menu <STRING>
 * 2: Icon <STRING>
 * 3: Statement <CODE>
 * 4: Condition <CODE>
 * 5: Insert children code <CODE> (Optional)
 * 6: Action parameters <ANY> (Optional)
 * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
 * 8: Distance <NUMBER> (Optional)
 * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
 * 10: Modifier function <CODE> (Optional)
 */
private _action = [
    "Fix camo net",
    "Fix camo net",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
    _pbar,
    {player distance _target < 15 && damage (_target getVariable 'shootnscoot_stationNet') > 0.9},
    {},
    [],
    [0,0,0],
    15
] call ace_interact_menu_fnc_createAction;
/*
 * Argument:
 * 0: Object the action should be assigned to <OBJECT>
 * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
 * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
 * 3: Action <ARRAY>
 */
[_this, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

// Vanilla menu, but with progress bar
_this addAction [
    "Fix camouflage net",
    _pbar,
    nil,
    6, // high up in priority
    true,
    true,
    "",
    "player distance _target < 15 && damage (_target getVariable 'shootnscoot_stationNet') > 0.9"
    ,
    20,
    false,
    "",
    ""
];
