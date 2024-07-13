/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_fixDroneAI.sqf
Parameters: none
Return: none

This function is a workaround for a Vanilla Arma bug.

Drones quite often lose their autonomous navigation skills.
This happens e.g. after performing a battery swap (ACE feature). 
Or when disableAI is called but later re-enabled (drone then still not functioning properly afterwards).

Using this function they are being reset to proper behaviour.

*///////////////////////////////////////////////

private _drone = getConnectedUAV player;

if (!isNull _drone) then {
	// delete old drone AI and create a new one
	deleteVehicleCrew _drone;
	createVehicleCrew _drone;
	hint parseText "<t color='#00ffff'>Should be fixed.</t><br/>Try again!";
} else {
	hint parseText "This restore function works on the drone you are currently connected to.<br/><t color='#ff0000'>You are not connected to any drone though.</t>";
};
