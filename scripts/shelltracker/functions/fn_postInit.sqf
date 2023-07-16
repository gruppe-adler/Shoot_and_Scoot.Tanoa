/**
  Whenever a player fires an artillery round, we want them shown for Zeus so they can track things easily.
  This function needs to be run whenever allPlayers changes (especially when new ones join)!!!
  TODO: Cleaner solution would be to only remoteExec to actual Zeus players instead of everyone, but I'm lazy.
*/
if !(hasInterface) exitWith {};

/**
  Kind of a workaround to ensure we register with every vehicle out there.
  Especially important for mortars, which can be "destroyed" and remade by packing them into backpacks, losing any existing EHs.
  Would also work if vehicle respawn mechanics get added later on.
*/
diag_log("(Re-)Init Shelltracker");
{
  if !(isNil {_x getVariable "shelltracker_GetIn_idx"}) then {continue }; // Already set up for this unit, we can skip
  private _getinidx = _x addEventHandler [ "GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    if !(isNull(_vehicle getVariable "shelltracker_onFired_idx")) exitWith {
      diag_log "onFired EH already added";
    };
    // TODO: We could add a vehicle filter here, to ensure we only init the tracker for artillery vehicles. Would also cut down amount of function calls.
    // if (_vehicle in ["VEHICLE NAME", "VEHICLE NAME", ...] exitWith{};
    private _idx =_vehicle call shelltracker_fnc_addFiredEH;
    _vehicle setVariable ["shelltracker_onFired_idx", _idx];
  }];
  _x setVariable ["shelltracker_GetIn_idx", _getinidx];
}foreach allPlayers;
