params ["_originatorPos", "_inAccurateOriginalPos", "_interceptPos"];
private _arrow = call arsr_fnc_initMarker;
_arrow setMarkerTypeLocal "hd_arrow";
_arrow setMarkerColorLocal arsr_markerColor;
_arrow setMarkerDirLocal (_interceptPos getDir _inAccurateOriginalPos);
