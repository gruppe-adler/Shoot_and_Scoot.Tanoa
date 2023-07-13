params ["_side", "_marker"];

_position = getMarkerPos _marker;
private _containerType = "";
private _netType = "";
switch (_side) do
{
    case west: {
        _containerType = "B_Slingload_01_Ammo_F";
        _netType = "CamoNet_BLUFOR_big_F";
    };

    case east: {
        _containerType = "Land_Pod_Heli_Transport_04_ammo_F";
        _netType = "CamoNet_ghex_big_F";
    };
    default {
        _containerType = "Banner_01_IDAP_F";          // if you see this IDAP sign there is a bug
        _netType = "CamoNet_INDP_open_F";
    };
};

// create objects for supply stations
_net = (_netType createVehicle _position);   // net first because it requires most space
_container = (_containerType createVehicle (getPosATL _net));
_container setVariable [ "id", _marker, true];
_container setVariable [ "side", _side, true];
_container lockInventory true;  // prevent inventory from being used (necessary for opfor container)

// apply a random rotation for variety
// if there is a road nearby, make sure the entry to the net is not facing away from the road
private _rotation = (random 360);
private _nearbyRoad = [_position, 65] call BIS_fnc_nearestRoad;
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
private _nearObjects  = nearestTerrainObjects [_position, [], 11];
{ hideObjectGlobal _x } forEach _nearObjects;

// clear area for supply stations from obstacles
private _nearObjects = nearestTerrainObjects [_position, [], 11];
{
    hideObjectGlobal _x
} forEach _nearObjects;

// add a trigger area to restock ammo trucks (incl. Stompers)
[_position, _rotation] call spot_randomizer_fnc_placeRestockArea;

// add menu entry that allows putting a damaged camo net back up
spot_randomizer_fnc_CamoNetBroken =  // inline function
{
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
spot_randomizer_fnc_RepairCamoNet =  // inline function
{
    private _nets = nearestObjects [player, ["CamoNet_BLUFOR_big_F", "CamoNet_ghex_big_F"], 10];
    {
        if (call spot_randomizer_fnc_CamoNetBroken) then {
            _x setDamage 0.9;   // once damaged it shall remain damaged (but standing)
        };
    } forEach _nets;
};
_container addAction [
    "Erect broken camouflage net",
    spot_randomizer_fnc_RepairCamoNet,
    nil,
            6, // high up in priority
    true,
    true,
    "",
    toString spot_randomizer_fnc_CamoNetBroken,
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

is_Zeus = !isNull (getAssignedCuratorLogic player);
if (is_Zeus) then {
    _container addEventHandler [ "HandleDamage", {
        params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
                // No need to spam useless information, we care about artillery hits only!
        if (_projectile in [
                                        "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
                                        "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
            ]) then {
                systemChat([_unit getVariable "id", "was hit by", _source, "for", (_damage - damage _unit) *100, "hitpoints with", _projectile, ". Current HP: ", _damage*100] joinString " ");
            }
        }];
    };

    _container;
