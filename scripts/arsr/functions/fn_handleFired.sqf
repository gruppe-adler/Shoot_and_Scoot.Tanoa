params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

// Check if shot originator was gunner
if ((gunner (vehicle _unit)) isNotEqualTo _gunner) exitWith {
    // You are not the gunner;
};

private _crew = crew (vehicle _unit);
if (_crew isEqualTo []) exitWith {
    // no crew, but who fired!?!?
};
private _artySide = side group (_crew select 0);

[getPos _unit, _artySide] call arsr_fnc_calculate;
