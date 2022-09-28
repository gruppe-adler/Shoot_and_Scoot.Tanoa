openMap [true, true];

hint "Click on the map to place a target";

private _mapClickEh = addMissionEventHandler ["MapSingleClick", {
	params ["", "_pos"];
	deleteMarker "target_loc";
	_marker = createMarkerLocal ["target_loc", _pos];
	_marker setMarkerType "HD_DOT";
	_marker setMarkerText "Target";
	artyTarget = _pos;
	openMap  [false, false];
}];

waitUntil {!visibleMap};

removeMissionEventHandler ["MapSingleClick", _mapClickEh]