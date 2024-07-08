if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create documentation topics for different game aspects


// playground
player createDiaryRecord  ["shootnscoot_diarySubject", ["Playground",
"This is a marker<br/>
<marker name='blufor_respawn'>Respawn point</marker>
<br/>
"]];


// Hunter killer docu
private _HunterRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["Hunter killer",
"<font color='#D18D1F' size='16'>Hunter killer teams</font><br/>
Blabla<br/>
<br/>
"]];


// Reconnaissance docu
private _ReconRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["Reconnaissance",
"<font color='#D18D1F' size='16'>Sound directionfinding</font><br/>
Blabla<br/>
<font color='#D18D1F' size='16'>Aerial reconnaissance</font><br/>
Drone blabla<br/>
"]];


// Arti docu
private _ArtiRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["Artillery",
"<font color='#D18D1F' size='16'>Artillery</font><br/>
Blabla<br/>
<font color='#D18D1F' size='16'>Mortar</font><br/>
During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus"]];


// General docu
player createDiaryRecord  ["shootnscoot_diarySubject", ["Introduction", format [
"<font color='#D18D1F' size='16'>Basic game principles</font><br/>
In this game mode <font color='#00ffff'>2x sides fight against each other</font>.<br/>
<br/>
Each team has the following <font color='#00ffff'>type of roles</font>:<br/>
- %1 <br/>
- %2 <br/>
- %3 <br/>
", 
createDiaryLink ["shootnscoot_diarySubject", _ArtiRecord, "Artillery"],
createDiaryLink ["shootnscoot_diarySubject", _ReconRecord, "Reconnaissance"],
createDiaryLink ["shootnscoot_diarySubject", _HunterRecord, "Hunter killer teams"]
]]];


// select top-most entry at game start
player selectDiarySubject "shootnscoot_diarySubject:Record-1";

