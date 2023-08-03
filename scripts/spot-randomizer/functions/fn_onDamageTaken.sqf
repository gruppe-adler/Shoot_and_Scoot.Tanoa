// CLIENT only!
if (!hasInterface) exitWith {};

// Only update for Zeus & Streamer
if (isNull(getAssignedCuratorLogic player)) exitWith {};
params ["_container", "_instigator", "_damage", "_ammo", "_damagePrv"];

private _dmg_dealt = (_damage - _damagePrv) * 100; // This var is in %

// Remember the last true damage dealing unit
if !(isNull(_instigator)) then {
    _container setVariable ["shootnscoot_lastDamageDealer", name _instigator];
};

// Special handling if target is destroyed. Update task & markers, then  cleanup EH + variables.
// TODO:    The marker updates will not work when Zeus is JIP, as they only update when damage is dealt. Might have to do an "init" run on all target units for JIP, maybe in postInit?
//          Must be extra cautious with initialization order, though!
if ((playerSide in [civilian, independent]) && _damage >= 1) exitWith { // TODO: When exactly does ACE cookoff start? When should the target count as actually "destroyed"?
    _station = (_container getVariable "shootnscoot_stationid");
    _taskID = (str playerSide) + _station;
    if ([_taskID] call BIS_fnc_taskExists) then { // task might not exist, e.g. for streamers
        [_taskID, "FAILED"] call BIS_fnc_taskSetState;
    };
    _station setMarkerTypeLocal "mil_objective";
    systemchat ([markerText _station, "has been destroyed by", _container getVariable "shootnscoot_lastDamageDealer"] joinString " ");
    _station setMarkerTextLocal ((markerText _station) + " destroyed");
};

// If regular damage, just show a message for Zeus&Streamer
if (_dmg_dealt < 3) exitWith {}; // Skip any tiny damage effects. These are probably just minor ACE frag damages.
private _message = [
    markerText (_container getVariable "shootnscoot_stationid"),
    "was hit by",
    name _instigator, "for",
    _dmg_dealt,
    "% with",
    _ammo,
    ". Current HP:", (1-_damage)*100, "%"] joinString " ";
systemChat _message;
