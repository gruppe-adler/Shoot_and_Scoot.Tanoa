if (easyarty_running) exitWith {};
if (isNil "ace_artillerytables_magModeData") exitWith { hint "You must have chosen an artillery solution!" };

call easyarty_fnc_setTargetPos;

easyarty_displayEh = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
	(_this select 0) drawLine [
		getPos player,
		easyarty_target,
		[0,0,1,1]
	];
}];

easyarty_pfh = [{
	private _solution = [easyarty_target, vehicle player] call easyarty_fnc_calculate;
	if (_solution isEqualTo []) exitwith {
		hintSilent "No solution found. Please try another range card setting!";
	};
	hintSilent format ["=== SOLUTION ===\nDISTANCE: %1\nELEVATION: %2\nAZIMUTH: %3\n", _solution select 2, _solution select 0, _solution select 1];
}, 1] call CBA_fnc_addPerFrameHandler;

easyarty_running = true;