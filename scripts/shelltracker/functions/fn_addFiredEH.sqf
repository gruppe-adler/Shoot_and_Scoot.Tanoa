// _this === vehicle object
if !(isNil{_this getVariable "shelltracker_Fired_idx"}) exitWith {}; // Already set up for this unit, we can skip

private _idx = _this addEventHandler ["Fired", {
  params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
  /**
    Drawing shell markers for Zeus and streamers.
  */
  // TODO: Ammo filter might not be necessary when using a vehicle filter in postInit already. But it's an option, and could even be combined.
  if (_ammo in [
    "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
    "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
  ]) then {
    [_projectile, _gunner, _magazine] call shelltracker_fnc_onFired;
  };
}];
_this setVariable ["shelltracker_Fired_idx", _idx];
