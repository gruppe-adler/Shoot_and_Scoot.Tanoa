if (!isServer) exitWith {};
params ["_side", "_stationid"];

_position = getMarkerPos _stationid;

// find me a good, flat spot at a distance of up to 150m away from the marker position
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
_container setVariable [ "shootnscoot_stationid", _stationid, true];
_container setVariable [ "shootnscoot_stationNet", _net, true];
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

//clear area for supply stations from obstacles
private _nearObjects  = nearestTerrainObjects [_fuzzyPosition, [], 11];
{ hideObjectGlobal _x } forEach _nearObjects;

sleep 3;  // wait for jerky physics to finish

// restore health after jerky Arma physics
_container setDamage 0.0;   // start with a bit over 50% hit points (requested by players)
_net       setDamage 0.8;   // start with low health to fix https://github.com/gruppe-adler/Shoot_and_Scoot.Tanoa/issues/29

_container remoteExec ["spot_randomizer_fnc_initStationClient", 0, true]; // Init any local container stuff for all players (incl. JIP!)

// add a trigger area to restock ammo trucks (incl. Stompers)
[_fuzzyPosition, _rotation] call spot_randomizer_fnc_placeRestockArea;

private _idx = _container addEventHandler [ "HandleDamage", {
    params ["_container", "_selection", "_damage", "_source", "_ammo", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
    private _damagePrv = damage _container;
    // No need to spam useless information, we care about artillery hits only!
    if (_ammo in [
        "rhs_ammo_3of56", "rhs_ammo_d462", "rhs_ammo_s463", "rhs_ammo_3of69m", // Howitzer rounds
        "Sh_82mm_AMOS", "Flare_82mm_AMOS_White", "Smoke_82mm_AMOS_White" // Mortar rounds
    ] || _damage >= 1) then {
        [_container, _instigator, _damage, _ammo, _damagePrv] remoteExec ["spot_randomizer_fnc_onDamageTaken", 0]; // Run on the server and every connected client
    };
    // Once container is destroyed, we can remove this handler and clean up.
    // HandleDamage keeps firing even if damage is > 1 for as long as object exists.
    if (_damage >= 1) then { // has to trigger once after full destruction
        _container removeEventHandler ["HandleDamage", _container getVariable "shootnscoot_HandleDamage_idx"];
        _container setVariable ["shootnscoot_HandleDamage_idx", nil];
    };
    nil // Ensure we return nil so we don't accidentally modify damage values...
}];
_container setVariable ["shootnscoot_HandleDamage_idx", _idx];

_container;
