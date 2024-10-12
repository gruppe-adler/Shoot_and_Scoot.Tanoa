params ["_side", "_stationid"];

private _position =  markerPos _stationid;
private _text = trim(markerText _stationid); // Must trim whitespaces from markerText
private _taskID = (str _side) + _stationid; // Tasks are side-specific, so we add it to the id


// show side dependent container and camo net image in the task descriptions
private _containerImage = "";
private _netImage = "";
switch (_side) do
{
    case west: {
        _containerImage = "<img src='\A3\EditorPreviews_F\Data\CfgVehicles\B_Slingload_01_Ammo_F.jpg' width='256' height='144' title='Blufor container' />";
        _netImage       = "<img src='\A3\EditorPreviews_F\Data\CfgVehicles\CamoNet_BLUFOR_big_F.jpg' width='370' height='208' title='Blufor camo net' />";
    };
    case east: {
        _containerImage = "<img src='\A3\EditorPreviews_F\Data\CfgVehicles\Land_Pod_Heli_Transport_04_ammo_F.jpg' width='256' height='144' title='Opfor container' />";
        _netImage       = "<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\CamoNet_ghex_big_F.jpg' width='370' height='208' title='Opfor camo net' />";
    };
};


// create task
[
    _side,
    _taskID,
    [["Up to 150m away from this position is/was one of your own supply containers. <br/>%1 <br/><br/>%2", _containerImage, _netImage],
    _text + " Supply Station",
    ""],    // deprecated parameter
    _position,
    "CREATED",
    -1,
    false,  // don't show popup notification to players when task is created
    "defend"
] call BIS_fnc_taskCreate;
