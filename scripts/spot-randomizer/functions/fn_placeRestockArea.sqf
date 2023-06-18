params ["_position", "_rotation"];


is_Zeus = !isNull (getAssignedCuratorLogic player); 


// START inline function definition ////////////////////////////

spot_randomizer_fnc_TriggerCondition =  // inline function
{
    private _return = false;
    
    vicsInZone = thisList select { _x isKindOf "LandVehicle"};
    {
        isSupplyVehicle = ([_x] call ace_rearm_fnc_isSource);
        if (isSupplyVehicle && !isEngineOn _x) then
        {           
            if (is_Zeus) then { systemChat "supply vehicle detected"; };  
            _return = true;
            break;
        };
    } forEach vicsInZone;

    _return;
};

spot_randomizer_fnc_onTriggerActivation = // inline function
{
    if (is_Zeus) then { systemChat "On Activation"; };
    
    vicsInZone = thisList select { _x isKindOf "LandVehicle"};
    {
        isSupplyVehicle = ([_x] call ace_rearm_fnc_isSource);
        if (isSupplyVehicle && !isEngineOn _x) then {
            _x setFuel 1; 
            if (_x isKindOf "UGV_01_base_F") then {
                rearmAmount = 400;
            } else {
                rearmAmount = 1200;
            };
            [_x, rearmAmount] call ace_rearm_fnc_setSupplyCount;
            if (is_Zeus) then { systemChat format ["refueled and restocked with %1 supply credits", rearmAmount]; };
        };
            
    } forEach thisList;
};


// END inline function definition ////////////////////////////


_trigger = createTrigger ["EmptyDetector", _position, true];
_trigger setTriggerText "resupply_trigger";
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerStatements [
    toString spot_randomizer_fnc_TriggerCondition, 
    toString spot_randomizer_fnc_onTriggerActivation, 
    ""
  ];
_trigger setTriggerArea [12, 10, _rotation, true];
_trigger setTriggerTimeout [15, 15, 15, true];
_trigger setTriggerInterval 3;
_trigger setSoundEffect ["RHS_Autoloader", "", "", ""];
