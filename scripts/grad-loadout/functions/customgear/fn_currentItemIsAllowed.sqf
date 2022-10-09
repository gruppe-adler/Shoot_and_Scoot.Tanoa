#include "component.hpp"

params ["_unit", "_currentItemKey", "_keyOptions"];
// _currentItemKey can be any of CUSTOMGEAR_SUPPORTED_KEYS here (see component.hpp)
// _keyOptions is an array of all custom gear options for the _currentItemKey
// _keyOptions is all lower case

private _fnc_getAllCyclableItems = {
    params ["_attributeName", "_currentItem"];

    private _cycleState = toLower _currentItem;
    private _return = [_cycleState];
    private _returnID = 0;

    while {_returnID >= 0} do {
        _cycleState = toLower ([configfile >> "CfgWeapons" >> _cycleState, _attributeName, _currentItem] call BIS_fnc_returnConfigEntry);
        _returnID = _return pushBackUnique _cycleState;
    };

    _return
};

// check if currently equipped item is one of the custom gear options
private _currentItem = [_unit, _currentItemKey] call FUNC(getCurrentItem);
if ((toLower _currentItem) in _keyOptions) exitWith {true};

// check if base item of currently equipped item
private _currentItemBase = [_unit, _currentItemKey, true] call FUNC(getCurrentItem);
if ((toLower _currentItemBase) in _keyOptions) exitWith {true};

// check if cyclable state of CBA_accessory (e.g. optics with magnifiers)
private _currentItemCyclableStates = ["MRT_SwitchItemNextClass", _currentItem] call _fnc_getAllCyclableItems;
if (count (_currentItemCyclableStates arrayIntersect _keyOptions) > 0) exitWith {true};

// check RHS base item (2D/3D/PiP optics)
private _currentItemBaseRHS = [configfile >> "CfgWeapons" >> _currentItem, "rhs_optic_base", _currentItem] call BIS_fnc_returnConfigEntry;
if ((toLower _currentItemBaseRHS) in _keyOptions) exitWith {true};

// check RHS cyclable state
private _currentItemCyclableStatesRHS = ["rhs_accessory_next", _currentItem] call _fnc_getAllCyclableItems;
if (count (_currentItemCyclableStatesRHS arrayIntersect _keyOptions) > 0) exitWith {true};

// check TFAR parent
private _currentItemTFARparent = [configfile >> "CfgWeapons" >> _currentItem, "tf_parent", _currentItem] call BIS_fnc_returnConfigEntry;
if ((toLower _currentItemTFARparent) in _keyOptions) exitWith {true};

false
