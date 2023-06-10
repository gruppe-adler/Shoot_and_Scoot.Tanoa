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
private _rotation = (random 360);
[_container, [_rotation,0,0]] call BIS_fnc_setObjectRotation;
[_net, [(_rotation+90) % 360,0,0]] call BIS_fnc_setObjectRotation;

sleep 3;  // wait for jerky physics to finish

// restore health after jerky Arma physics
_container setDamage 0.4;   // start with a bit over 50% hit points (requested by players)
_net       setDamage 0.0;   // fix broken nets 

//clear area for supply stations from obstacles
private _nearObjects  = nearestTerrainObjects [_position, [], 11];
{ hideObjectGlobal _x } forEach _nearObjects;
// diag_log format ["_nearObjects=%1", _nearObjects];
// { _x remoteExecCall ["hideObjectGlobal", 2] } forEach _nearObjects;
