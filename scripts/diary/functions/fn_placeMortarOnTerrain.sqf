/*/////////////////////////////////////////////////
Author: Bernhard
			   
File: fn_placeMortarOnTerrain.sqf
Parameters: none
Return: none

This function is a workaround for a suspected ACE glitch.

During unloading of mortars quite a lot of them disappear. 
They are then located below the surface.

Using this function they are being brought back to the surface.

See https://github.com/acemod/ACE3/issues/10010 for more information.

*///////////////////////////////////////////////

private _mortar = localNamespace getVariable "shootnscoot_lastUnloadedMortar";

// write to server RPT when this workaround is used
private _ServerLogEntry = format ["fn_placeMortarOnTerrain.sqf called by %1 while 'shootnscoot_lastUnloadedMortar=%2' and 'getPosATL=%3'.", name player, _mortar, getPosATL _mortar];
[_ServerLogEntry] remoteExec ["diag_log", 2];

if (!isNil "_mortar") then {
	private _pos = getPosATL _mortar;
	_mortar setPosATL [_pos#0, _pos#1, 0];		// place at same x and y coordinate, but with z coordinate on the surface
	hint parseText "<t color='#00ffff'>Should be fixed.</t><br/>Check your surroundings for the mortar!";
} else {
	hint parseText "This restore function works on the last mortar that you've unloaded.<br/><t color='#ff0000'>You haven't unloaded a mortar yet.</t>";
};
