#include "component.hpp"

params [["_unit", objNull], ["_loadoutHash", []], ["_ignoreCurrentLoadout", false]];

private _loadoutOptionsHash = [[], false] call CBA_fnc_hashCreate;
private _currentLoadout = getUnitLoadout _unit;
private _allowedCategories = _unit getVariable [QGVAR(customGearAllowedCategories), GVAR(customGearAllowedCategories)];

{
    private _key = _x;
    private _value = [_loadoutHash, _key] call CBA_fnc_hashGet;
    if (!isNil "_value" && {_value isEqualType []}) then {_value = _value apply {toLower _x}};

    if (
        !isNil "_value" &&
        {_value isEqualType []} &&
        {count _value > 0} &&
        {
            _ignoreCurrentLoadout ||
            [_unit, _key, _value] call FUNC(currentItemIsAllowed)            
        }
    ) then {
        [_loadoutOptionsHash, _key, _value] call CBA_fnc_hashSet;
    };
} forEach ([CUSTOMGEAR_SUPPORTED_KEYS] arrayIntersect _allowedCategories);

_loadoutOptionsHash
