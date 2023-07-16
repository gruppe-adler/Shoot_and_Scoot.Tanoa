systemchat "onDamaged";
diag_log "onDamaged";
if (!hasInterface) exitWith {};
if (isNull(getAssignedCuratorLogic player)) exitWith {};
systemchat "ondamaged2";
diag_log "onDamaged2";
params ["_unit", "_instigator", "_damage", "_ammo", "_damagePrv"];

diag_log _unit;
diag_log _instigator;
diag_log _damage;
diag_log damage _unit;
diag_log _ammo;
private _dmg_dealt = (_damage - _damagePrv) * 100;
if (_dmg_dealt < 3 || _damage < 5) exitWith {}; // skip any messages with tiny effects or when container already dead. These are probably just minor ACE frag damages. TODO: When exactly does ACE cookoff start? When should the target count as actually "destroyed"?
private _message = [markerText (_unit getVariable "id"), "was hit by", name _instigator, "for", _dmg_dealt, "% with", _ammo, ". Current HP:", (1-_damage)*100, "%"] joinString " ";
systemChat _message;
diag_log _message;
