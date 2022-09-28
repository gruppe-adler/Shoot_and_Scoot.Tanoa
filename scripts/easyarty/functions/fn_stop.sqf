if (!easyArtyRunning) exitWith {};

easyArtyPfh call CBA_fnc_removePerFrameHandler;
(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw", easyArtyDisplayEh];
deleteMarker "target_loc";

easyArtyRunning = false;