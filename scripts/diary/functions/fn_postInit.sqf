if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create documentation topics for different game aspects

// mortar docu
player createDiaryRecord  ["shootnscoot_diarySubject", ["Mortar","During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus"]];
