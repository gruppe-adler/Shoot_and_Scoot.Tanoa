["ace_explosives_place", {
    params ["_explosive", "", "", "_unit"];
    if !(arsr_allowPlacedExplosives) exitWith {};
    private _hit = getNumber (configFile >> "CfgAmmo" >> typeOf _explosive >> "hit");
    if (_hit < arsr_explosivesMinHit) exitWith {};

    if (arsr_explosivesAddSide && {!isNull _unit}) then {
        _explosive setVariable ["arsr_side", side group _unit];
    };

    _explosive addEventHandler ["Explode", {
        params ["_explosive", "_pos", "_velocity"];
        ["arsr_shotEvent", [_pos, _explosive getVariable ["arsr_side", sideLogic]]] call CBA_fnc_serverEvent;
    }];
}] call CBA_fnc_addEventHandler;

if !(isServer) exitWith {};

arsr_listeners = [];
{
    [_x, "init", {
        params ["_vehicle"];
        arsr_listeners pushBack _vehicle;
    }, false, [], true] call CBA_fnc_addClassEventHandler;

    [_x, "Killed", {
        params ["_vehicle"];
        arsr_listeners = arsr_listeners - [_vehicle, objNull];
    }, false] call CBA_fnc_addClassEventHandler;
} forEach (arsr_listenerClassesSetting splitString "[,""']");

{
    [_x,"Fired", {_this call arsr_fnc_handleFired}, true] call CBA_fnc_addClassEventHandler;
} forEach (arsr_artilleryBaseClassesSetting splitString "[,""']");

["arsr_shotEvent", {
    _this call arsr_fnc_calculate;
}] call CBA_fnc_addEventHandler;
