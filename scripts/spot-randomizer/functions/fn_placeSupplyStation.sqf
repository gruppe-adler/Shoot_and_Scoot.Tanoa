params ["_side", "_position"];

private _containerType = "";
private _netType = "";
switch (_side) do
{
	case west:  { _containerType = "B_Slingload_01_Ammo_F"; 
                _netType       = "CamoNet_BLUFOR_big_F";
              };
              
	case east:  { _containerType = "Land_Pod_Heli_Transport_04_ammo_F"; 
                _netType       = "CamoNet_ghex_big_F";
              };
              
	default     { _containerType = "Banner_01_IDAP_F";          // if you see this IDAP sign there is a bug
                _netType       = "CamoNet_INDP_open_F";
              };  
};

// create objects for supply stations
_net = (_netType createVehicle _position);   // net first because it requires most space
_container = (_containerType createVehicle (getPosATL _net));

// apply a random rotation for variety
// if there is a road nearby, make sure the entry to the net is not facing away from the road
private _rotation = (random 360);
private _nearbyRoad = [_position, 65] call BIS_fnc_nearestRoad;
if (not isNull _nearbyRoad) then { 
    _rotation = _net getRelDir _nearbyRoad;   // don't use the random rotation if there's a road nearby
    _rotation = (_rotation + 180) % 360;      // turn around 180° because this is how camo nets work :-/
};
[_net, [_rotation,0,0]] call BIS_fnc_setObjectRotation;
[_container, [(_rotation+90) % 360,0,0]] call BIS_fnc_setObjectRotation;

sleep 3;  // wait for jerky physics to finish

// restore health after jerky Arma physics
_container setDamage 0.4;   // start with a bit over 50% hit points (requested by players)
_net       setDamage 0.0;   // fix broken nets 

//clear area for supply stations from obstacles
private _nearObjects  = nearestTerrainObjects [_position, [], 11];
{ hideObjectGlobal _x } forEach _nearObjects;
// diag_log format ["_nearObjects=%1", _nearObjects];
// { _x remoteExecCall ["hideObjectGlobal", 2] } forEach _nearObjects;
