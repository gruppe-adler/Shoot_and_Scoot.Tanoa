if !(hasInterface) exitWith {};
// _this === station container

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
        alive player and (player distance _this#0) < 12 &&
        isNull objectParent player &&
        speed(_this#0) < 3
    }
] call ace_common_fnc_progressBar;
};

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
    "Fix broken camouflage net",
    _pbar,
    nil,
    6, // high up in priority
    true,
    true,
    "",
    "player distance _target < 12 && damage (_target getVariable 'shootnscoot_stationNet') > 0.9"
    ,
    20,
    false,
    "",
    ""
];
