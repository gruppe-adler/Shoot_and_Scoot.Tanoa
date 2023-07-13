/**
  Whenever a player fires an artillery round, we want to notify Zeus so they can track things easily.
  TODO: Cleaner solution would be to only remoteExec to actual Zeus players instead of everyone, but I'm lazy.
*/
if !(hasInterface) exitWith {};


{
  private _idx =_x addEventHandler ["Fired", {
    systemchat "A shell has been fired!";
    diag_log "A shell has been fired!";
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    /**
      Drawing shell markers for Zeus and streamers.
    */
    diag_log("This is the local projectile!");
    diag_log(_projectile);
    diag_log(_ammo);
    if (_Ammo in [
      "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
      "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
    ]) then {
      systemchat ((name _gunner) + " fired a shot");
      diag_log ((name _gunner) + " fired a shot");
      [_projectile, _gunner, _magazine] call shelltracker_fnc_onShellFired;
    };
  }];
  // _x setVariable ["shellTracker_FiredEH", _idx];

} forEach vehicles;

// player addEventHandler ["GetInMan", {
//   params ["_unit", "_role", "_vehicle", "_turret"];
//   systemchat "getin";
//   diag_log "getin";

//   _idx = _vehicle addEventHandler ["Fired", {
//     systemchat "A shell has been fired!";
//     diag_log "A shell has been fired!";
//     params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
//     /**
//       Drawing shell markers for Zeus and streamers.
//     */
//     diag_log("This is the local projectile!");
//     diag_log(_projectile);
//     diag_log(_ammo);
//     if (_Ammo in [
//       "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
//       "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
//     ]) then {
//       systemchat (name _gunner) + " fired a shot";
//       diag_log (name _gunner) + " fired a shot";
//       [_projectile, _gunner, _magazine] remoteExec ["shelltracker_fnc_onShellFired"];
//     };
//   }];
  // localNamespace setVariable ["shellTracker_FiredEH", _idx];

  // player addEventHandler ["GetOutMan", {
  //   params ["_unit", "_role", "_vehicle", "_turret"];
  //   systemchat "getout";
  //   diag_log "getout";
  //   systemchat str localNamespace getVariable "shellTracker_FiredEH";
  //   systemchat str _thisEventHandler;
  //   diag_log localNamespace getVariable "shellTracker_FiredEH";
  //   diag_log _thisEventHandler;
  //   _vehicle removeEventHandler ["Fired", localNamespace getVariable "shellTracker_FiredEH"];
  //   player removeEventHandler ["GetOutMan", _thisEventHandler];
  // }];
// }];
