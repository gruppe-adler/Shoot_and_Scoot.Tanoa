if (!hasInterface) exitWith {};
if (isNull(getAssignedCuratorLogic player)) exitWith {};
params ["_unit", "_instigator", "_damage", "_ammo", "_damagePrv"];

private _dmg_dealt = (_damage - _damagePrv) * 100;
if (_dmg_dealt < 3 || _damage < 5) exitWith {}; // skip any messages with tiny effects or when container already dead. These are probably just minor ACE frag damages. TODO: When exactly does ACE cookoff start? When should the target count as actually "destroyed"?
private _message = [markerText (_unit getVariable "id"), "was hit by", name _instigator, "for", _dmg_dealt, "% with", _ammo, ". Current HP:", (1-_damage)*100, "%"] joinString " ";
systemChat _message;
