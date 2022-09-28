if (easyArtyRunning) exitWith {};
if (isNil "ace_artillerytables_magModeData") exitWith { hint "You must have chosen an artillery sheet!" };

call easyarty_fnc_setTargetPos;

easyArtyDisplayEh = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw", {
	(_this select 0) drawLine [
		getPos player,
		artyTarget,
		[0,0,1,1]
	];
}];

easyArtyPfh = [{
	private _solution = [artyTarget, vehicle player] call easyarty_fnc_calculate;
	if (_solution isEqualTo []) exitwith {
		hintSilent "No solution found. Please try another range card setting!";
	};
	hintSilent format ["=== SOLUTION ===\nDISTANCE: %1\nELEVATION: %2\nAZIMUTH: %3\n", _solution select 2, _solution select 0, _solution select 1];
}, 1] call CBA_fnc_addPerFrameHandler;

easyArtyRunning = true;