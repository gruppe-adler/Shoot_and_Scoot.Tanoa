if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create documentation topics for different game aspects

// create empty diary records
private _RespawnRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["",""]];
private _HunterRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["",""]];
private _ReconRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["",""]];
private _ArtiRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["",""]];
private _IntroRecord = player createDiaryRecord  ["shootnscoot_diarySubject", ["",""]];

private _back2IntroLink = createDiaryLink ["shootnscoot_diarySubject", _IntroRecord, "back to Introduction"],


// General docu
player setDiaryRecordText [["shootnscoot_diarySubject", _IntroRecord], ["Introduction", format [
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


// Arti docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ArtiRecord], ["Artillery",
"<font color='#D18D1F' size='16'>Artillery</font><br/>
Blabla<br/>
<font color='#D18D1F' size='16'>Mortar</font><br/>
During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus<br/>
<br/>" + _back2IntroLink]];


// Reconnaissance docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ReconRecord], ["Reconnaissance",
"<font color='#D18D1F' size='16'>Sound directionfinding</font><br/>
Blabla<br/>
<font color='#D18D1F' size='16'>Aerial reconnaissance</font><br/>
Drone blabla<br/>
<br/>
" + _back2IntroLink]];


// Hunter killer docu
player setDiaryRecordText [["shootnscoot_diarySubject", _HunterRecord], ["Hunter killer",
"<font color='#D18D1F' size='16'>Hunter killer teams</font><br/>
Blabla<br/>
<br/>
" + _back2IntroLink]];

// Respawn docu
player setDiaryRecordText [["shootnscoot_diarySubject", _RespawnRecord], ["Respawn",
"At mission start players spawn together on a <marker name='common_briefing_area'>southern island</marker>. <br/>
Zeus will give a quick introduction there. <br/>
<br/>
<font color='#00ffff'>Flag poles serve as teleporters</font> to get players to their base. 
After dying players will respawn in their own base. <br/>
- <marker name='blufor_safespace'>Blufor base</marker> <br/>
- <marker name='opfor_safespace'>Opfor base</marker> <br/>
<br/>
"]];



// select top-most entry at game start
player selectDiarySubject "shootnscoot_diarySubject:Record-1";

