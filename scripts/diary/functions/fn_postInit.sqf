if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create empty diary records
private _WorkaroundsRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _RespawnRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _CommanderRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _HunterRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _ReconRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _MortarRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _ArtiRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _IntroRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];

// create links to chapters
private _ArtiLink = createDiaryLink ["shootnscoot_diarySubject", _ArtiRecord, "Artillery"];
private _MortarLink = createDiaryLink ["shootnscoot_diarySubject", _MortarRecord, "Mortar"];
private _ReconLink = createDiaryLink ["shootnscoot_diarySubject", _ReconRecord, "Reconnaissance"];
private _HunterLink = createDiaryLink ["shootnscoot_diarySubject", _HunterRecord, "Hunter killer teams"];
private _CommanderLink = createDiaryLink ["shootnscoot_diarySubject", _CommanderRecord, "Commanders"];
private _back2IntroLink = "<br/><br/>" + createDiaryLink ["shootnscoot_diarySubject", _IntroRecord, "back to Introduction"];


// create workaround functions (as a potential self-service for players)
private _MortarUnloadWorkaround = "<br/>
------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Mortar unload bug</font> <br/>
During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus<br/>
<br/>";

private _DroneAIWorkaround = "<br/>
------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Drone AI bug</font> <br/>
Arma's drone AI is quite prone to breaking. <br/>
Then a <font color='#00ffff'>drone can't operate autonomously anymore</font>. <br/>
Using the link below you should be able to restore them. <br/>
<executeClose expression='call diary_fnc_fixDroneAI'>Fix drone AI</executeClose><br/>
<br/>
Another way of fixing this manually for Darter drones is <br/>
to <font color='#00ffff'>disassemble them (into a backpack) and then reassembling</font> them.
<br/>";


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
The containers can be used to rearm any %1 and %4  <br/>
(both yours end the enemies; you can steal ammo from the other faction). <br/>
<br/>
To make spotting them more challenging they are <font color='#00ffff'>hidden under a large camo net</font>. <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\CamoNet_BLUFOR_big_F.jpg' width='370' height='208' title='Blufor camo net' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\CamoNet_ghex_big_F.jpg' width='370' height='208' title='Opfor camo net' /> <br/>
<br/>
%2 players use Darter UAVs and signal directionfinders to <font color='#00ffff'>develop a situation picture</font>. <br/>
<br/>
%3 perform <font color='#00ffff'>search and destroy</font> on the %1 teams. <br/>
", _ArtiLink, _ReconLink, _HunterLink, _MortarLink
]]];


// Arti docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ArtiRecord], ["Artillery", format [
"<font color='#D18D1F' size='16'>Artillery</font> <br/>
Artillery requires intel from the %1 elements for targeting information.<br/>
<img src='rhsafrf\addons\rhs_editorPreviews\data\rhs_D30_vdv.paa' width='370' height='208' title='artillery type is the same for both sides' /> <br/>
The artillery piece is towed by a truck that also brings ammunition.
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_B_Ural_Ammo.jpg' width='370' height='208' title='Blufor towing ammo truck' /> 
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_O_Ural_Ammo.jpg' width='370' height='208' title='Opfor towing ammo truck' /> <br/>
See the <font color='#00ffff'>Field Manual</font> section named <font color='#00ffff'>RHS: Towing</font> for how towing artillery pieces works. <br/>
(available from the Escape menu) <br/>
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
<font color='#ff0000'>-</font> no ammo in the transport vic <br/>
<font color='#ff0000'>-</font> no lower arc firing possible <br/>

<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_T_Mortar_01_F.jpg' width='256' height='144' title='Blufor mortar' /> 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\O_Mortar_01_F.jpg' width='256' height='144' title='Opfor mortar' /> <br/>

Mortars can be transported in MRAPs. <br/>
Their <font color='#00ffff'>speed limit is set to 90 km/h</font>. <br/>
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_T_MRAP_01_F.jpg' width='370' height='208' title='Blufor MRAP' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\O_T_MRAP_02_ghex_F.jpg' width='370' height='208' title='Opfor MRAP' /> <br/>
" + _MortarUnloadWorkaround + _back2IntroLink]];


// Reconnaissance docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ReconRecord], ["Reconnaissance", format [
"<font color='#D18D1F' size='16'>Sound directionfinding</font> <br/>
This sensor is a truck that starts operation <br/>
- <font color='#00ffff'>as soon as mast is erected</font> <br/>
- <font color='#00ffff'>as long as an operator sits inside</font> (can be any player) <br/>
<br/>
To erect the mast: <br/>
1. take the <font color='#00ffff'>driver seat</font> <br/>
2. use Vanilla mouse menu <br/>
3. use menu entry <font color='#00ffff'>Deploy Mast</font> <br/>
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_gaz66\data\ui\UK3CB_CHD_B_Gaz66_Radio.jpg' width='370' height='208' title='Blufor sound directionfinder truck (mast not deployed)' /> 
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_gaz66\data\ui\UK3CB_CHD_O_Gaz66_Radio.jpg' width='370' height='208' title='Opfor sound directionfinder truck (mast not deployed)' /> <br/>
<br/>
<font color='#00ffff'>Only</font> %1 <font color='#00ffff'>operators and</font> %2 <font color='#00ffff'>of the faction can see directionfinding results</font> on the map. <br/>
<br/>
Be aware that: <br/>
- <font color='#00ffff'>Sound needs time to travel</font> from the shooter to your directionfinders. <br/>
  You won't see all bearing lines for all events instantaneously. <br/>
- <font color='#00ffff'>Bearing lines have an error of up to %3°</font> from the real direction of the shooting %4. <br/>
<br/>
<br/>
<br/>
<font color='#D18D1F' size='16'>Aerial reconnaissance</font> <br/>
Drone blabla<br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\B_UAV_01_F.jpg' width='370' height='208' title='Blufor UAV' /> 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\O_UAV_01_F.jpg' width='370' height='208' title='Opfor UAV' /> <br/>
", _ReconLink, _CommanderLink, arsr_angleError, _ArtiLink] + _DroneAIWorkaround + _back2IntroLink]];


// Hunter killer docu
player setDiaryRecordText [["shootnscoot_diarySubject", _HunterRecord], ["Hunter killer",
"<font color='#D18D1F' size='16'>Hunter killer teams</font> <br/>
are small fire teams with just enough people to easily overwhelm artillery teams. <br/>
They are highly mobile with their light strike vehicles (LSV). <br/>
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\B_T_LSV_01_unarmed_F.jpg' width='370' height='208' title='Blufor LSV' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\O_T_LSV_02_unarmed_F.jpg' width='370' height='208' title='Opfor LSV' /> <br/>
<br/>
These teams get directed to their search and destroy areas by <font color='#00ffff'>forwarding them artillery location finding results</font> from the reconnaissance elements. <br/>
Once they are in the general vicinity of enemy artillery they can hear artillery firing by themselves, which also guides them. <br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Electronic Warfare</font> <br/>
Hunter killer teams also bring Electronic Warfare (EW in short) capabilities if the <font color='#00ffff'>Engineer / EW operator</font> slot is taken.
" + _back2IntroLink]];


private _myVLS = nil;
switch (playerSide) do
{
    case west: { _myVLS = blufor_vls; };
    case east: { _myVLS = opfor_vls; };
};

// Commander docu
player setDiaryRecordText [["shootnscoot_diarySubject", _CommanderRecord], ["Commanders", format [
"<font color='#D18D1F' size='16'>Commanders</font> <br/>
The commanders are the <font color='#00ffff'>top-most leaders</font> their faction. <br/>
<br/>
They are the only persons that are not a %1 operator but still <font color='#00ffff'>see the directionfinders bearings</font>. <br/>
<br/>
<font color='#D18D1F' size='14'>Cruise Missile strike</font> <br/>
In addition they are the only ones authorized to <font color='#00ffff'>launch Cruise Missile strikes</font> from the destroyer near the own base. <br/>
(lower ranking players can't connect their UAV terminal to this asset)
<img src='\A3\EditorPreviews_F_Destroyer\Data\Cfgvehicles\Destroyer_01_assembled.jpg' width='370' height='208' title='Destroyer' /> <br/>
<img src='\A3\EditorPreviews_F_Destroyer\Data\Cfgvehicles\B_Ship_MRLS_01_F.jpg' width='370' height='208' title='Cruise Missile launcher' /> <br/>
How to strike? <br/>
1. <font color='#00ffff'>provide a laser lock on target</font> from a drone <br/>
2. open UAV terminal and connect to Cuise missile launcher <br/>
3. go into the Gunner position <br/>
4. check <font color='#00ffff'>sensor display</font> (right side of screen per default) for laser spots <br/>
5. <font color='#00ffff'>select the laser spot</font> you wish to shoot at <br/>
5.1. by pressing your <font color='#00ffff'>%2</font> hotkey <font color='#00ffff'>%3</font> (once or more often) <br/>
6. wait for laser lockon beeping sound to change from a lower to a higher pitch <br/>
7. fire weapon <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\B_UAV_01_F.jpg' width='256' height='144' title='Blufor UAV' /> 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\O_UAV_01_F.jpg' width='256' height='144' title='Opfor UAV' /> <br/>
<br/>
Be aware that you only have <font color='#00ffff'>%4 missle(s)</font> available. <br/>
So use them carefully for high-value targets. <br/>
", _ReconLink, actionName "vehLockTargets", actionKeysNames "vehLockTargets", _myVLS ammo "weapon_VLS_01"] + _back2IntroLink]];


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


// Workarounds section (for quick and easy access)
player setDiaryRecordText [["shootnscoot_diarySubject", _WorkaroundsRecord], ["Workarounds", _MortarUnloadWorkaround + _DroneAIWorkaround]];


// select top-most entry at game start
player selectDiarySubject "shootnscoot_diarySubject:Record-1";
