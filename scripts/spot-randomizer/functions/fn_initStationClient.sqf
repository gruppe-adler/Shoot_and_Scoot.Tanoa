if !(hasInterface) exitWith {};
// _this === station container

params ["_container"];

private _is_Zeus = !isNull (getAssignedCuratorLogic player);

if (_is_Zeus) then {
    _container addEventHandler ["Killed", {
        params ["_container", "_killer", "_instigator", "_useEffects"];

        // Update task & markers
        // TODO:    The marker updates will not work when Zeus is JIP, as they only update when the container is finally killed. 
        //          Might have to do an "init" run on all target units for JIP, maybe in postInit?
        //          Must be extra cautious with initialization order, though!
        private _station = (_container getVariable "shootnscoot_stationid");
        private _taskID = (str playerSide) + _station;
        if ([_taskID] call BIS_fnc_taskExists) then { // task might not exist, e.g. for streamers
            [_taskID, "FAILED", false] call BIS_fnc_taskSetState;
        };
        _station setMarkerTypeLocal "mil_objective";
        systemchat ([markerText _station, "has been destroyed by", _container getVariable "shootnscoot_lastDamageDealer"] joinString " ");
        _station setMarkerTextLocal ((markerText _station) + " destroyed");
    }];
};


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
