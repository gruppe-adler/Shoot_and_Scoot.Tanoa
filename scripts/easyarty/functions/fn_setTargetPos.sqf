openMap [true, true];

hint "Click on the map to place a target";

private _mapClickEh = addMissionEventHandler ["MapSingleClick", {
	params ["", "_pos"];
	deleteMarkerLocal "target_loc";
	private _marker = createMarkerLocal ["target_loc", _pos];
	_marker setMarkerTypeLocal "HD_DOT";
	_marker setMarkerTextLocal "Target";
	easyarty_target = _pos;
	openMap  [false, false];
}];

waitUntil {!visibleMap};

removeMissionEventHandler ["MapSingleClick", _mapClickEh]