if (isNull(getAssignedCuratorLogic player)) exitWith {}; // Only Zeus gets to see this for now. Maybe CMD/sensor as well, later on?
// _this === vehicle object
if !(isNil{this getVariable "shelltracker_Fired_idx"}) exitWith {}; // Already set up for this unit, we can skip

private _idx = _this addEventHandler ["Fired", {
  params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  /**
    Drawing shell markers for Zeus and streamers.
  */
  diag_log("This is the local projectile!");
  diag_log(_projectile);
  diag_log(_ammo);
  if (_ammo in [
    "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
    "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
  ]) then {
    systemchat ((name _gunner) + " fired a shot");
    diag_log ((name _gunner) + " fired a shot");
    [_projectile, _gunner, _magazine] call shelltracker_fnc_onFired;
  };
}];
_this setVariable ["shelltracker_Fired_idx", _idx];
