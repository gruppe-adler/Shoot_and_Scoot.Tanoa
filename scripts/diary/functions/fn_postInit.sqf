if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create empty diary records
private _RespawnRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _HunterRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _ReconRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _MortarRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _ArtiRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _IntroRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];

// create links to chapters
private _ArtiLink = createDiaryLink ["shootnscoot_diarySubject", _ArtiRecord, "Artillery"];
private _ReconLink = createDiaryLink ["shootnscoot_diarySubject", _ReconRecord, "Reconnaissance"];
private _HunterLink = createDiaryLink ["shootnscoot_diarySubject", _HunterRecord, "Hunter killer teams"];
private _back2IntroLink = "<br/><br/>" + createDiaryLink ["shootnscoot_diarySubject", _IntroRecord, "back to Introduction"];


// Introduction to game mode
player setDiaryRecordText [["shootnscoot_diarySubject", _IntroRecord], ["Introduction", format [
"<font color='#D18D1F' size='16'>Basic game principles</font> <br/>
In this game mode <font color='#00ffff'>2x sides fight against each other</font>. <br/>
<br/>
Each team has the following <font color='#00ffff'>type of roles</font>: <br/>
- %1 <br/>
- %2 <br/>
- %3 <br/>
<br/>
Both parties <font color='#00ffff'>try to destroy the enemies supply containers</font> with their %1. <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\B_Slingload_01_Ammo_F.jpg' width='256' height='144' title='Blufor container' /> <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\Land_Pod_Heli_Transport_04_ammo_F.jpg' width='256' height='144' title='Opfor container' /> <br/>
The containers are hidden under a large camo net.
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\CamoNet_BLUFOR_big_F.jpg' width='370' height='208' title='Blufor camo net' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\CamoNet_ghex_big_F.jpg' width='370' height='208' title='Opfor camo net' /> <br/>
<br/>
%2 players use Darter UAVs and signal directionfinders to <font color='#00ffff'>develop a situation picture</font>. <br/>
<br/>
%3 perform <font color='#00ffff'>search and destroy</font> on the artillery teams. <br/>
", _ArtiLink, _ReconLink, _HunterLink
]]];


// Arti docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ArtiRecord], ["Artillery", format [
"<font color='#D18D1F' size='16'>Artillery</font> <br/>
Artillery requires intel from the %1 elements for targeting information.<br/>
<img src='rhsafrf\addons\rhs_editorPreviews\data\rhs_D30_vdv.paa' width='370' height='208' title='artillery type is the same for both sides' />  <br/>
The artillery piece is towed by a truck that also brings ammunition.
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_B_Ural_Ammo.jpg' width='370' height='208' title='Blufor towing ammo truck' /> 
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_O_Ural_Ammo.jpg' width='370' height='208' title='Opfor towing ammo truck' /> <br/>
", _ReconLink
] + _back2IntroLink]];


// Mortar docu
player setDiaryRecordText [["shootnscoot_diarySubject", _MortarRecord], ["- Mortar",
"<font color='#D18D1F' size='16'>Mortar</font> <br/>
The mortar is an alternative to the towed artillery. <br/>

<font color='#00ff00'>PROs</font> <br/>
<font color='#00ff00'>+</font> higher mobility <br/>
<font color='#00ff00'>+</font> higher rate of fire <br/>
<font color='#00ff00'>+</font> higher accuracy 
<br/>

<font color='#ff0000'>CONs</font> <br/>
<font color='#ff0000'>-</font> lower damage per hit <br/>
<font color='#ff0000'>-</font> shorter projectile range <br/>
<font color='#ff0000'>-</font> no laser guided shells <br/>
<font color='#ff0000'>-</font> no ammo in the transport vic <br/>
<font color='#ff0000'>-</font> no lower arc firing possible <br/>

<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_T_Mortar_01_F.jpg' width='256' height='144' title='Blufor mortar' /> 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\O_Mortar_01_F.jpg' width='256' height='144' title='Opfor mortar' /> <br/>

Mortars can be transported in MRAPs. <br/>
Their <font color='#00ffff'>speed limit is set to 90 km/h</font>. <br/>
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_T_MRAP_01_F.jpg' width='370' height='208' title='Blufor MRAP' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\O_T_MRAP_02_ghex_F.jpg' width='370' height='208' title='Opfor MRAP' /> <br/>

<font color='#00ffff' size='14'>Mortar unload bug</font> <br/>
During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus<br/>
" + _back2IntroLink]];


// Reconnaissance docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ReconRecord], ["Reconnaissance",
"<font color='#D18D1F' size='16'>Sound directionfinding</font> <br/>
Blabla<br/>
<font color='#ffff00'>TODO: insert pic of DFs</font> <br/>
<br/>
<br/>
<font color='#D18D1F' size='16'>Aerial reconnaissance</font> <br/>
Drone blabla<br/>
<br/>
" + _back2IntroLink]];


// Hunter killer docu
player setDiaryRecordText [["shootnscoot_diarySubject", _HunterRecord], ["Hunter killer",
"<font color='#D18D1F' size='16'>Hunter killer teams</font> <br/>
are small fire teams with just enough people to easily overwhelm artillery teams. <br/>
They are highly mobile with their light vehicles. <br/>
<br/>
These teams get directed to their search and destroy areas by <font color='#00ffff'>forwarding them artillery location finding results</font> from the reconnaissance elements. <br/>
Once they are in the general vicinity of enemy artillery they can hear artillery firing by themselves, which also guides them. <br/>
<br/>
<br/>
<font color='#D18D1F' size='16'>Electronic Warfare</font> <br/>
Hunter killer teams also bring Electronic Warfare (EW in short) capabilities if the <font color='#00ffff'>Engineer / EW operator</font> slot is taken.
" + _back2IntroLink]];


// Respawn docu
player setDiaryRecordText [["shootnscoot_diarySubject", _RespawnRecord], ["Spawn and respawn",
"<font color='#D18D1F' size='16'>Spawn</font> <br/>
At mission start players spawn together on a <marker name='common_briefing_area'>southern island</marker>. <br/>
Zeus will give a quick introduction there. <br/>
<br/>
<font color='#00ffff'>Flag poles serve as teleporters</font> to get players to their base. 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\Flag_NATO_F.jpg' width='256' height='144' title='Blufor teleporter' /> <br/>
<br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\Flag_CSAT_F.jpg' width='256' height='144' title='Opfor teleporter' /> <br/>
<br/>
<font color='#D18D1F' size='16'>Respawn</font> <br/>
After dying players will respawn in their own base. <br/>
- <marker name='blufor_safespace'>Blufor base</marker> <br/>
- <marker name='opfor_safespace'>Opfor base</marker> <br/>
"]];


// select top-most entry at game start
player selectDiarySubject "shootnscoot_diarySubject:Record-1";
