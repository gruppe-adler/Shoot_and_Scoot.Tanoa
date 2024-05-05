// allow U menu for easier team management
["Initialize", [true]] call BIS_fnc_dynamicGroups;



// define ACE fortify tool (budget and objects)
[west, 500, [
			["Land_BagFence_01_short_green_F", 5],
			["Land_BagFence_01_round_green_F", 5],
			["Land_BagFence_01_long_green_F", 10],
			["CamoNet_BLUFOR_F", 10], 
			["CamoNet_BLUFOR_open_F", 5],  
			["CamoNet_BLUFOR_big_F", 15]
		]
	] call ace_fortify_fnc_registerObjects;


[east, 500, [
			["Land_BagFence_01_short_green_F", 5],
			["Land_BagFence_01_round_green_F", 5],
			["Land_BagFence_01_long_green_F", 10],
			["CamoNet_ghex_F", 10], 
			["CamoNet_ghex_open_F", 5], 
			["CamoNet_ghex_big_F", 15]
		]
	] call ace_fortify_fnc_registerObjects;
