if (!easyarty_running) exitWith {};

easyarty_pfh call CBA_fnc_removePerFrameHandler;
(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw", easyarty_displayEh];
deleteMarkerLocal "target_loc";

easyarty_running = false;