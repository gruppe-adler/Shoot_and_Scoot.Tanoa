params ["_originatorPos", "_falseHeading", "_interceptPos", "_side", ["_radioCall", false]];

if (!_radioCall && ((side player) isNotEqualTo independent)) then { // don't clutter streamers interface with these messages
	systemChat "Artillery shot detected! Drawing on map!";
};

call arsr_fnc_drawLines;
