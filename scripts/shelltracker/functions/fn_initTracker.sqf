/*
Inits the tracker for Zeus only.
This does NOT handle the case where a Zeus gets his CuratorLogic unassigned. If this becomes a requirement, this script needs to remove the EHs instead of just skipping.
If an array of units is given as parameter, it will be initialized only for those. If not, it will check allPlayers.
Whenever a player fires an artillery round, we want them shown for Zeus so they can track things easily.
This function needs to be run whenever allPlayers changes (especially when new ones join) or when someone respawns!!!
*/

if !(hasInterface) exitWith {};

diag_log("_this in initTracker is:");
diag_log(_this);
params [["_unitsToUpdate", allPlayers, [[]]]];

private _fnc = {
    if (isNull(getAssignedCuratorLogic player)) exitWith {}; // Only Zeus gets to see this for now. Maybe CMD/sensor as well, later on?
    // Kind of a workaround to ensure we register with every vehicle out there.
    // Especially important for mortars, which can be "destroyed" and remade by packing them into backpacks, losing any existing EHs.
    // Would also work if vehicle respawn mechanics get added later on.
    // EHs are stored per object using setVariable to ensure we never double-add EHs by accident
    diag_log("_this in initTracker _fnc is:");
    diag_log(_this);
    {
        // If already set up for this unit, we skip. We must check if EH actually exists, bc it gets lost during respawn.
        if (!(isNil {_x getVariable "shelltracker_GetIn_idx"}) && (_x getEventHandlerInfo ["GetInMan", _x getVariable "shelltracker_GetIn_idx"] select 0)) then { continue };
        private _getinidx = _x addEventHandler [ "GetInMan", {
            params ["_unit", "_role", "_vehicle", "_turret"];
            // TODO: We could add a vehicle filter here, to ensure we only init the tracker for artillery vehicles. Would also cut down amount of function calls.
            // if (_vehicle in ["VEHICLE NAME", "VEHICLE NAME", ...] exitWith{};
            _vehicle call shelltracker_fnc_addFiredEH;
        }];
        _x setVariable ["shelltracker_GetIn_idx", _getinidx];
    } foreach _this;
};

// CuratorLogic only gets assigned a short interval after mission start, so this stupid workaround is necessary
if (time < 3) then {
    [_unitsToUpdate, _fnc] spawn {
        params ["_unitsToUpdate", "_fnc"];

        sleep 3;
        _unitsToUpdate call _fnc;
    };
} else {
    _unitsToUpdate call _fnc;
};

