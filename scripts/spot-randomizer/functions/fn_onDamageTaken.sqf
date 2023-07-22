if (!hasInterface) exitWith {}; // CLIENT only!
// Only update for Zeus & Streamer
if (isNull(getAssignedCuratorLogic player)) exitWith {};
params ["_unit", "_instigator", "_damage", "_ammo", "_damagePrv"];

private _dmg_dealt = (_damage - _damagePrv) * 100; // This var is in %

// Special handling if target is destroyed. Update task & markers, then  cleanup EH + variables.
// TODO:    The marker updates will not work when Zeus is JIP, as they only update when damage is dealt. Might have to do an "init" run on all target units for JIP, maybe in postInit?
//          Must be extra cautious with initialization order, though!
if ((playerSide in [civilian, independent]) && _damage >= 1) exitWith { // TODO: When exactly does ACE cookoff start? When should the target count as actually "destroyed"?
    _marker = (_unit getVariable "id");
    [(str playerSide) + _marker, "FAILED"] call BIS_fnc_taskSetState;
    _marker setMarkerTypeLocal "mil_objective";
    systemchat ([markerText _marker, "has been destroyed by", _unit getVariable "shootnscoot_lastDamageDealer"] joinString " ");
    _marker setMarkerTextLocal ((markerText _marker) + " destroyed");
};

// If regular damage, just show a message for Zeus&Streamer
if (_dmg_dealt < 3) exitWith {}; // Skip any tiny damage effects. These are probably just minor ACE frag damages.
if !(isNull(_unit)) then {
    _unit setVariable ["shootnscoot_lastDamageDealer", name _instigator];
};
private _message = [markerText (_unit getVariable "id"), "was hit by", name _instigator, "for", _dmg_dealt, "% with", _ammo, ". Current HP:", (1-_damage)*100, "%"] joinString " ";
systemChat _message;
