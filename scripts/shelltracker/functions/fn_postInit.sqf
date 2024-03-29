// Whenever a player fires an artillery round, we want them shown for Zeus so they can track things easily.
// This function needs to be run whenever allPlayers changes (especially when new ones join)!!!
if !(hasInterface) exitWith {};

private _fnc = {
    if (isNull(getAssignedCuratorLogic player)) exitWith {}; // Only Zeus gets to see this for now. Maybe CMD/sensor as well, later on?
    // Kind of a workaround to ensure we register with every vehicle out there.
    // Especially important for mortars, which can be "destroyed" and remade by packing them into backpacks, losing any existing EHs.
    // Would also work if vehicle respawn mechanics get added later on.
    // EHs are stored per object using setVariable to ensure we never double-add EHs by accident
    {
        if !(isNil {_x getVariable "shelltracker_GetIn_idx"}) then { continue }; // Already set up for this unit, we can skip
        private _getinidx = _x addEventHandler [ "GetInMan", {
            params ["_unit", "_role", "_vehicle", "_turret"];
            // TODO: We could add a vehicle filter here, to ensure we only init the tracker for artillery vehicles. Would also cut down amount of function calls.
            // if (_vehicle in ["VEHICLE NAME", "VEHICLE NAME", ...] exitWith{};
            _vehicle call shelltracker_fnc_addFiredEH;
        }];
        _x setVariable ["shelltracker_GetIn_idx", _getinidx];
    } foreach allPlayers;
};

// CuratorLogic only gets assigned a short interval after mission start, so this stupid workaround is necessary
if (time < 3) then {
    _fnc spawn {
        sleep 3;
        call _this;
    };
} else {
    call _fnc;
};

