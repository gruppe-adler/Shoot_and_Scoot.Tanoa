if (!isServer) exitWith {};
params ["_side", "_marker"];

_position = getMarkerPos _marker;

// find me a good, flat spot at a distance of up t0 150m away from the marker position
// don't be in the sea and if no such position is found default to the original provided position
private _fuzzyPosition = [_position, 0,  150, 10, 0, 0.2, 0, [], [_position, _position]] call BIS_fnc_findSafePos;


private _containerType = "";
private _netType = "";
switch (_side) do
{
    case west: {
        _containerType = "B_Slingload_01_Ammo_F";
        _netType       = "CamoNet_BLUFOR_big_F";
    };

    case east: {
        _containerType = "Land_Pod_Heli_Transport_04_ammo_F";
        _netType       = "CamoNet_ghex_big_F";
    };
    default {
        _containerType = "Banner_01_IDAP_F";      // if you see this IDAP sign there is a bug
        _netType       = "CamoNet_INDP_open_F";
    };
};

// create objects for supply stations
private _net       = (_netType createVehicle _fuzzyPosition);   // net first because it requires most space
private _container = (_containerType createVehicle (getPosATL _net));
_container setVariable [ "id", _marker, true];
_container setVariable [ "side", _side, true];
_container lockInventory true;  // prevent inventory from being used (necessary for opfor container)

// apply a random rotation for variety
// if there is a road nearby, make sure the entry to the net is not facing away from the road
private _rotation = (random 360);
private _nearbyRoad = [_fuzzyPosition, 65] call BIS_fnc_nearestRoad;
if (not isNull _nearbyRoad) then {
    _rotation = _net getRelDir _nearbyRoad;   // don't use the random rotation if there's a road nearby
    _rotation = (_rotation + 180) % 360;      // turn around 180° because this is how camo nets work :-/
};
[_net, [_rotation, 0, 0]] call BIS_fnc_setObjectRotation;
[_container, [(_rotation+90) % 360, 0, 0]] call BIS_fnc_setObjectRotation;

sleep 3;  // wait for jerky physics to finish

// restore health after jerky Arma physics
_container setDamage 0.0;   // start with a bit over 50% hit points (requested by players)
_net       setDamage 0.0;   // fix broken nets


//clear area for supply stations from obstacles
private _nearObjects  = nearestTerrainObjects [_fuzzyPosition, [], 11];
{ hideObjectGlobal _x } forEach _nearObjects;

// clear area for supply stations from obstacles
private _nearObjects = nearestTerrainObjects [_position, [], 11];
{
    hideObjectGlobal _x
} forEach _nearObjects;

// add a trigger area to restock ammo trucks (incl. Stompers)
[_fuzzyPosition, _rotation] call spot_randomizer_fnc_placeRestockArea;

// add menu entry that allows putting a damaged camo net back up
private _spot_randomizer_fnc_CamoNetBroken =  {
    private _return = false;
    private _nets = nearestObjects [player, ["CamoNet_BLUFOR_big_F", "CamoNet_ghex_big_F"], 10];
    {
        if (damage _x > 0.9) then {
            _return = true;
            break;
        };
    } forEach _nets;
    _return;
};
private _spot_randomizer_fnc_RepairCamoNet = {
    private _nets = nearestObjects [player, ["CamoNet_BLUFOR_big_F", "CamoNet_ghex_big_F"], 10];
    {
        if (call spot_randomizer_fnc_CamoNetBroken) then {
            _x setDamage 0.9;   // once damaged it shall remain damaged (but standing)
        };
    } forEach _nets;
};
_container addAction [
    "Erect broken camouflage net",
    _spot_randomizer_fnc_RepairCamoNet,
    nil,
        6, // high up in priority
    true,
    true,
    "",
    toString _spot_randomizer_fnc_CamoNetBroken,
    20,
    false,
    "",
    ""
];
/* TODO: I would prefer a Hold action but it does not work yet :-(
[
    _container, // Object the action is attached to
    "Erect broken camouflage net", // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // Progress icon shown on screen
    toString spot_randomizer_fnc_CamoNetBroken, // Condition for the action to be shown
    "_caller distance _target < 15", // Condition for the action to progress
    {}, // Code executed when action starts
    {}, // Code executed on every progress tick
        {
        call spot_randomizer_fnc_RepairCamoNet;
    }, // Code executed on completion
    {}, // Code executed on interrupted
    [], // Arguments passed to the scripts as _this select 3
    10, // action duration in seconds
    0, // priority
    false, // Remove on completion
    false// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, _container];// MP compatible implementation
*/


private _idx = _container addEventHandler [ "HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_ammo", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
    private _damagePrv = damage _unit;
    // No need to spam useless information, we care about artillery hits only!
    if (_ammo in [
        "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
        "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
    ] || _damage >= 1) then {
    [_unit, _instigator, _damage, _ammo, _damagePrv] remoteExec ["spot_randomizer_fnc_onDamageTaken"];
    };
    // Once container is destroyed, we can remove this handler and clean up.
    if (_damage >= 1) then { // has to trigger once after full destruction
        _unit removeEventHandler ["HandleDamage", _unit getVariable "shootnscoot_HandleDamage_idx"];
        _unit setVariable ["shootnscoot_HandleDamage_idx", nil];
    };
    nil // Ensure we return nil so we don't accidentally modify damage values...
}];
_container setVariable ["shootnscoot_HandleDamage_idx", _idx];

_container;
