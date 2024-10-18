/**
Visualize flying shells for Zeus.
This should be 100% LOCAL only, as it's PFH!
*/
if !(hasInterface) exitWith {};
params ["_projectile", "_gunner", "_magazine"];

// Drawing shell markers for Zeus and streamers.
private _markerColor = [side _gunner, true ] call BIS_fnc_sideColor;
private _ammo = getText(configfile >> "CfgMagazines" >> _magazine >> "ammo");
private _ammoname = getText(configfile >> "CfgMagazines" >> _magazine >> "displayName");
private _radius = getNumber(configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange") * 1.2;
private _markerName = [diag_tickTime, _magazine, name _gunner] joinString "";
private _marker = createMarkerLocal [_markerName, _projectile];
private _gunnerInfo = name _gunner;
if (["missile", _ammoname, false] call BIS_fnc_inString) then {
    _marker setMarkerTextLocal _ammoname;
    _marker setMarkerTypeLocal "mil_arrow";    // special marker for cruise missiles
    _marker setMarkerSizeLocal [1.0, 1.0];
    _gunnerInfo = side _gunner;
} else {
    _marker setMarkerTypeLocal "hd_start";      // default marker for arti shell
    _marker setMarkerSizeLocal [0.4, 0.4];
};
systemchat format ["%1 just fired %2", _gunnerInfo, _ammoname];
_marker setMarkerColorLocal _markerColor;
_projectile setVariable ["marker", _markerName];
_projectile setVariable ["markerRadius", _radius];

// Update marker position of projectile in PFH
[{
    private _proj = _this#0#0;
    if (!alive _proj) exitWith {
        [_this#1] call CBA_fnc_removePerFrameHandler;
    };
    private _marker = _proj getVariable "marker";
    _marker setMarkerPosLocal _proj;
    _marker setMarkerDirLocal (getDir _proj);

    // if (typeOf _proj == 'ammo_Missile_Cruise_01') then {
    //     systemChat format ["missileTarget = %1", missileTarget _proj];
    // };
}, 0, [_projectile]] call CBA_fnc_addPerFrameHandler;

// When the projectile "dies", change to impact marker handling.
_projectile addEventHandler ["Deleted", {
    params ["_projectile", "_pos", "_velocity"];
    private _marker = _projectile getVariable "marker";
    private _radius = _projectile getVariable "markerRadius";
    // diag_log format ["fn_onFired.sqf Deleted_EH: _projectile = '%1', _pos = '%2', _velocity = '%3', _marker = '%4', _radius = '%5'", _projectile, _pos, _velocity, _marker, _radius];
    _marker setMarkerTypeLocal "mil_destroy_noShadow";
    // Tiny scheduled loop to handle change over time and cleanup without the PFH.
    [_marker, _radius] spawn {
        private _marker = _this#0;
        private _radius = _this#1;
        private _alpha = 1;
        private _markerRadius = createMarkerLocal [_marker + "radius", getMarkerPos _marker];
        _markerRadius setMarkerShapeLocal "ELLIPSE";
        _markerRadius setMarkerSizeLocal [_radius * 2, _radius * 2];  // markerSize is diameter
        _markerRadius setMarkerColorLocal (getMarkerColor _marker);
        _markerRadius setMarkerBrushLocal "Border";
        // Fade out impact markers over 10 seconds.
        while {_alpha > 0} do {
            _alpha = _alpha - 0.1;
            sleep 1;
            _marker setMarkerAlphaLocal _alpha;
            _markerRadius setMarkerAlphaLocal _alpha;
        };
        // Finally, we clean up markers.
        // Not explicitly cleaning up projectile variables, because projectiles are gone anyway now.
        deleteMarkerLocal _marker;
        deleteMarkerLocal _markerRadius;
    };
}];
