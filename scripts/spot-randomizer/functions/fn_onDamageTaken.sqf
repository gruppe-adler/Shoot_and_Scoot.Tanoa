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
private _ammoname = getText(configfile >> "CfgAmmo" >> _ammo >> "displayName");
private _message = [_unit getVariable "id", "was hit by", name _instigator, "for", (_damage - _damagePrv) *100, "% with", _ammoname, ". Current HP:", (1-_damage)*100, "%"] joinString " ";
systemChat _message;
diag_log _message;
