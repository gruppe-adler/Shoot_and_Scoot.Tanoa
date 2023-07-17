/**
  Visualize flying shells for Zeus.
  This should be 100% LOCAL only, as it's PFH!
*/
if !(hasInterface) exitWith {};
params ["_projectile", "_gunner", "_magazine"];

/**
Drawing shell markers for Zeus and streamers.
*/
private _markerColor = [side _gunner, true ] call BIS_fnc_sideColor;
private _ammo = getText(configfile >> "CfgMagazines" >> _magazine >> "ammo");
private _ammoname = getText(configfile >> "CfgMagazines" >> _magazine >> "displayName");
private _radius = getNumber(configfile >> "CfgAmmo" >> _ammo >> "indirectHitRange") * 2;
systemchat ((name _gunner) + " just fired " + _ammoname);
private _markerName = [diag_tickTime, _magazine, name _gunner] joinString "";
private _marker = createMarkerLocal [_markerName, _projectile];
_marker setMarkerTypeLocal "mil_dot_noShadow";
private _markerText = [_ammoname, "by", name _gunner] joinString " ";
_marker setMarkerTextLocal _markerText;
_marker setMarkerColorLocal _markerColor;
_projectile setVariable ["marker", _markerName];
_projectile setVariable ["markerRadius", _radius];
// When the projectile "dies", change to impact marker handling.
_projectile addEventHandler ["Deleted", {
  params ["_projectile", "_pos", "_velocity"];
  private _marker = _projectile getVariable "marker";
  private _radius = _projectile getVariable "markerRadius";
  _marker setMarkerTypeLocal "mil_destroy_noShadow";
  [_marker, _radius] spawn {
    private _marker = _this#0;
    private _radius = _this#1;
    private _alpha = 1;
    private _markerRadius = createMarkerLocal [_marker + "radius", getMarkerPos _marker];
    _markerRadius setMarkerShapeLocal "ELLIPSE";
    _markerRadius setMarkerSizeLocal [_radius, _radius];
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
[{
  private _proj = _this#0#0;
  if (!alive _proj) exitWith {
      [_this#1] call CBA_fnc_removePerFrameHandler;
  };
  private _marker = _proj getVariable "marker";
  _marker setMarkerPosLocal _proj;
}, 0, [_projectile]] call CBA_fnc_addPerFrameHandler;
