if !(hasInterface) exitWith {};

// create root of ingame documentation
player createDiarySubject ["shootnscoot_diarySubject","Shoot and Scoot"];

// create empty diary records
private _WorkaroundsRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _RespawnRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
private _OmniJammerRecord = player createDiaryRecord ["shootnscoot_diarySubject", ["",""]];
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
private _OmniJammerLink = createDiaryLink ["shootnscoot_diarySubject", _OmniJammerRecord, "Drone jammer"];
private _back2IntroLink = "<br/><br/>" + createDiaryLink ["shootnscoot_diarySubject", _IntroRecord, "back to Introduction"];


// create workaround functions (as a potential self-service for players)
private _MortarUnloadWorkaround = "<br/>
------------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Mortar unload bug</font> <br/>
During past games quite a few <font color='#00ffff'>Mk6 mortars got lost after unloading them</font> from the vehicle.<br/>
Using the link below you should be able to restore them.<br/>
<executeClose expression='call diary_fnc_placeMortarOnTerrain'>Fix lost mortar</executeClose><br/>
<br/>
In case it doesn't work for you --> ping Zeus<br/>
<br/>";

private _DroneAIWorkaround = "<br/>
------------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Drone AI bug</font> <br/>
Arma's drone AI is quite prone to breaking. <br/>
Then a <font color='#00ffff'>drone can't operate autonomously anymore</font>. <br/>
(e.g. happens when you do a <execute expression='[""ACE_Items"", ""ACE_UAVBattery""] call BIS_fnc_openFieldManual'>battery swap with ACE</execute>) <br/>
<br/>
Using the link below you should be able to restore them. <br/>
<executeClose expression='call diary_fnc_fixDroneAI'>Fix drone AI</executeClose><br/>
<br/>
Another way of fixing this manually for Darter drones is <br/>
to <font color='#00ffff'>disassemble them (into a backpack) and then reassembling</font> them. <br/>
<br/>";

private _ChangeSeatWorkaround = format ["<br/>
------------------------------------------------------------------------------------------------ <br/>
<font color='#ff00ff' size='14'>Change seat >> ejection bug</font> <br/>
When you go fast in a vehicle, changing seats via the <font color='#ff0000'>Vanilla menu</font> can have you ejected from it. <br/>
This mostly happens to %1. <br/>
<br/>
To play it save you should use the <font color='#00ff00'>ACE menu</font> for changing seats. <br/>
<br/>", _HunterLink];


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
The containers can be used to rearm any %1 and %4. <br/>
(both yours end the enemies; you can steal ammo from the other faction) <br/>
<br/>
To make spotting them more challenging they are <font color='#00ffff'>hidden under a large camo net</font>. <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\CamoNet_BLUFOR_big_F.jpg' width='370' height='208' title='Blufor camo net' /> 
<img src='\A3\EditorPreviews_F_Exp\Data\CfgVehicles\CamoNet_ghex_big_F.jpg' width='370' height='208' title='Opfor camo net' /> <br/>
<br/>
%2 players use <br/>
- signal directionfinders <br/>
- <execute expression='[""VehicleList"", ""UAVrotor""] call BIS_fnc_openFieldManual'>Darter UAVs</execute> <br/>
to <font color='#00ffff'>develop a situation picture</font>. <br/>
<br/>
%3 perform <font color='#00ffff'>search and destroy</font> on the %1 teams. <br/>
", _ArtiLink, _ReconLink, _HunterLink, _MortarLink
]]];


// Arti docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ArtiRecord], ["Artillery", format [
"<font color='#D18D1F' size='16'>Artillery</font> <br/>
Artillery requires intel from the %1 elements for targeting information. <br/>
<br/>
It can be fired via <font color='#00ffff'>Artillery Computer</font> or <br/>
via manual targeting using <font color='#00ffff'>Artillery Range Tables</font>. <br/>
<br/>
<img src='rhsafrf\addons\rhs_editorPreviews\data\rhs_D30_vdv.paa' width='256' height='144' title='artillery type is the same for both sides' /> <br/>
<br/>
<font color='#D18D1F' size='14'>Towing</font> <br/>
The artillery piece is towed by a truck that also brings ammunition. <br/>
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_B_Ural_Ammo.jpg' width='256' height='144' title='Blufor towing ammo truck' /> 
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_ural\data\ui\UK3CB_CHD_O_Ural_Ammo.jpg' width='256' height='144' title='Opfor towing ammo truck' /> <br/>
See the <execute expression='[""RHS_Towing"", ""RHS_AFRF_Towing_Prepare"", nil, ""towing""] call BIS_fnc_openFieldManual'>Field Manual on towing</execute> for how towing artillery pieces works. <br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Artillery Computer</font> <br/>
When using the <execute expression='[""Tactics"", ""Ballistic""] call BIS_fnc_openFieldManual'>Artillery Computer</execute>, make sure to wait for the FIRE button to turn from <img src='pics\arti_fire_button_red.jpg' width='64' height='32' title='Do not shoot! Barrel is still moving' /> to <img src='pics\arti_fire_button_white.jpg' width='64' height='32' title='Barrel is aligned on target. You may fire now.' /> before clicking it. <br/>
<br/>
Only then will your barrel have stopped moving for shot alignment. <br/>
<font color='#ff0000'>If you fire before that, you will miss your target.</font> <br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Manual aiming with range tables</font> <br/>
Using Artillery Range Tables comes with the following PROs and CONs: <br/>
<br/>
<font color='#00ff00'>PROs</font> <br/>
<font color='#00ff00'>+</font> lower arc firing solutions possible <br/>
<font color='#00ff00'>+</font> lower arcs can have <font color='#00ff00'>significantly shorter time on target</font>  <br/>
   (e.g. <font color='#00ff00'>7s</font> vs. <font color='#ff0000'>40s</font> from <marker name='blufor_safespace'>Blufor base</marker> to center of map; effect cumulates with adjusting fire) <br/>
<br/>
<font color='#ff0000'>CONs</font> <br/>
<font color='#ff0000'>-</font> for experienced players only <br/>
<font color='#ff0000'>-</font> manual calculation takes time <br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Fortify Tool</font> <br/>
For better survivability crews can place: <br/>
- sandbag barriers <br/>
- camo nets <br/>
using the <execute expression='[""ACE_Items"", ""ACE_FortifyTool""] call BIS_fnc_openFieldManual'>Fortify Tool</execute>. <br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Rearming</font> <br/>
This is how you can rearm your artillery piece. <br/>
<img src='pics\take_ammo_from_truck.jpg' width='370' height='208' title='Taking ammo from truck (or supply container)' /> <br/>
<img src='pics\put_ammo_into_gun.jpg' width='370' height='208' title='Rearming the gun with th ammo box' /> 
Supply containers can also be used to get ammo from. <br/>
<br/>
Note that you can rearm the %2 the same way, but the default transport vehicle of the mortar does not bring any ammo. <br/>
", _ReconLink, _MortarLink
] + _back2IntroLink]];

// Or click the links below (once you are in-game). <br/>
// - <execute expression='[[""RHS_Towing"",""RHS_AFRF_Towing_Prepare""],  15, false, 35, false, true, true, false, true] call BIS_fnc_advHint'>Prepare for towing</execute><br/>
// - <execute expression='[[""RHS_Towing"",""RHS_AFRF_Towing_Attach""],   15, false, 35, false, true, true, false, true] call BIS_fnc_advHint'>Attach for towing</execute><br/>
// - <execute expression='[[""RHS_Towing"",""RHS_AFRF_Towing_Detach""],   15, false, 35, false, true, true, false, true] call BIS_fnc_advHint'>Detach from towing</execute><br/>
// - <execute expression='[[""RHS_Towing"",""RHS_AFRF_Towing_Dragging""], 15, false, 35, false, true, true, false, true] call BIS_fnc_advHint'>Drag after towing</execute><br/>


// Mortar docu
player setDiaryRecordText [["shootnscoot_diarySubject", _MortarRecord], ["Mortar", format [
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
<br/>
<font color='#D18D1F' size='14'>Rearming</font> <br/>
See the %1 section for how to rearm the mortar. <br/>
It uses the same procedure. <br/>
", _ArtiLink
] + _MortarUnloadWorkaround + _back2IntroLink]];


// Reconnaissance docu
player setDiaryRecordText [["shootnscoot_diarySubject", _ReconRecord], ["Reconnaissance", format [
"<font color='#D18D1F' size='16'>Sound directionfinding</font> <br/>
This sensor is a truck that starts operation <br/>
- <font color='#00ffff'>as soon as mast is erected</font> <br/>
- <font color='#00ffff'>as long as an operator sits inside</font> (can be any player) <br/>
<br/>
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_gaz66\data\ui\UK3CB_CHD_B_Gaz66_Radio.jpg' width='370' height='208' title='Blufor sound directionfinder truck (mast not deployed)' /> 
<img src='UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_gaz66\data\ui\UK3CB_CHD_O_Gaz66_Radio.jpg' width='370' height='208' title='Opfor sound directionfinder truck (mast not deployed)' /> <br/>
<br/>
To erect the mast: <br/>
1. take the <font color='#00ffff'>driver seat</font> <br/>
2. use Vanilla mouse menu (<font color='#00ffff'>%5</font>) <br/>
3. select menu entry <font color='#00ffff'>Deploy Mast</font> (<font color='#00ffff'>%6</font>) <br/>
<img src='pics\deploy_mast_menu_entry.jpg'  width='250' height='250' title='Select highlighted menu entry to erect the mast' /> <br/> 
<br/>
<br/>
<font color='#D18D1F' size='14'>Result display</font> <br/>
<img src='pics\directionfinder_results_on_map.jpg' width='370' height='370' title='Blufor will see blue lines, Opfor will see red lines' /> <br/> 
Be aware that: <br/>
- %1 operators and %2 are <font color='#00ffff'>the only roles that can see directionfinding results</font> on the map. <br/>
- <font color='#00ffff'>Sound needs time to travel</font> from the shooter to your directionfinders. <br/>
  You won't see all bearing lines for all events instantaneously. <br/>
- <font color='#00ffff'>Bearing lines have an error of up to %3°</font> from the real direction of the shooting %4. <br/>
<br/>
<br/>
<br/>
<font color='#D18D1F' size='16'>Aerial reconnaissance</font> <br/>
For aerial reconnaissance Recon operators have <execute expression='[""VehicleList"", ""UAVrotor""] call BIS_fnc_openFieldManual'>Darter UAVs</execute> <br/>
<font color='#00ffff'>in backpacks stored in their trucks</font>. <br/>
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\B_UAV_01_F.jpg' width='370' height='208' title='Blufor UAV' /> 
<img src='\A3\EditorPreviews_F\Data\CfgVehicles\O_UAV_01_F.jpg' width='370' height='208' title='Opfor UAV' /> <br/>
Appart from doing recon, the UAVs are also used to provide <font color='#00ffff'>laser designation</font> on the request of the %2, to allow for cruise missile strikes. <br/>
<br/>
See the <execute expression='[""UAV"", ""Basics"", nil, ""uav""] call BIS_fnc_openFieldManual'>Field Manual on UAVs</execute> for further information. <br/>
<br/>
A demonstration on how to <font color='#00ffff'>command the drone from the gunner position</font> can be seen <br/>
in a 1min long YouTube video. <br/>
1. <execute expression='copyToClipboard ""https://www.youtube.com/watch?v=8vF_b2aJ12s"";'>copy URL of video</execute> <br/>
2. then press <font color='#00ffff'>Ctrl+V</font> into browser address bar <br/>
", _ReconLink, _CommanderLink, arsr_angleError, _ArtiLink, actionKeysNames "nextAction", actionKeysNames "ActionContext"] + _DroneAIWorkaround + _back2IntroLink]];


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
Hunter killer teams also bring Electronic Warfare (EW in short) capabilities if the <font color='#00ffff'>Engineer / EW operator</font> slot is taken. <br/>
" + _ChangeSeatWorkaround + _back2IntroLink]];


// Commander docu
private _myVLS = nil;
switch (playerSide) do
{
    case west: { _myVLS = blufor_vls; };
    default    { _myVLS = opfor_vls; };
};
private _VLSauthorized = ["<font color='#ff0000'>NOT authorized</font>", "<font color='#00ff00'>authorized</font>"] select (rankId player >= 3);
player setDiaryRecordText [["shootnscoot_diarySubject", _CommanderRecord], ["Commanders", format [
"<font color='#D18D1F' size='16'>Commanders</font> <br/>
The commanders are the <font color='#00ffff'>top-most leaders</font> of their faction. <br/>
<br/>
They are the only persons that are not %1 operators <br/>
but still <font color='#00ffff'>see the directionfinder bearings</font>. <br/>
<img src='pics\directionfinder_results_on_map.jpg' width='370' height='370' title='Blufor will see blue lines, Opfor will see red lines' /> <br/> 
<br/>
<br/>
<font color='#D18D1F' size='14'>UGV</font> <br/>
Remote controlled logistics can be done with unarmed <execute expression='[""VehicleList"", ""UGV""] call BIS_fnc_openFieldManual'>Stomper UGVs</execute>. <br/>
They allow for: <br/>
- transporting people <br/>
- rearming any %6 and %7 <br/>
   (but not as much ammo as truck has) <br/>
<br/>
Use of the UGVs is open for anyone with a UAV terminal (not limited to just Commanders).<br/>
<br/>
<br/>
<font color='#D18D1F' size='14'>Cruise Missile strike</font> <br/>
Commanders are the only ones authorized to <font color='#00ffff'>launch Cruise Missile strikes</font> <br/>
from the destroyer near the own base. <br/>
Lower ranking players can't connect their UAV terminal to this asset. <br/>
You, as a <font color='#00ffff'>%8</font>, are %9 to connect. <br/>
<img src='\A3\EditorPreviews_F_Destroyer\Data\Cfgvehicles\Destroyer_01_assembled.jpg' width='256' height='144' title='Destroyer' /> <br/>
<img src='\A3\EditorPreviews_F_Destroyer\Data\Cfgvehicles\B_Ship_MRLS_01_F.jpg' width='256' height='144' title='Cruise Missile launcher' /> <br/>
How to strike? <br/>
1. <font color='#00ffff'>provide a laser lock on target</font> from a drone <br/>
2. open UAV terminal and connect to Cuise missile launcher <br/>
3. go into the Gunner position <br/>
4. check <font color='#00ffff'>sensor display</font> (right side of screen per default) for laser spots <img src='A3\Ui_f\data\IGUI\RscCustomInfo\Sensors\Targets\LaserTarget_ca.paa'  color='#ff0000'width='16' height='16' title='Laser spot as indicated on the sensor display' /> <br/>
5. <font color='#00ffff'>select the laser spot</font> you wish to shoot at <br/>
5.1. by pressing your <font color='#00ffff'>%2</font> hotkey <font color='#00ffff'>%3</font> (once or more often) <br/>
5.2. laser spot <img src='A3\Ui_f\data\IGUI\RscCustomInfo\Sensors\Targets\LaserTarget_ca.paa' color='#ff0000' width='16' height='16' title='Laser spot as indicated on the sensor display' /> should then show a marker around it <img src='A3\Ui_f\data\IGUI\RscCustomInfo\Sensors\Targets\MarkedTarget_ca.paa' width='16' height='16' title='Laser spot as indicated on the sensor display' /> <br/>
<img src='pics\sensor_display_laser_target_selected.jpg' width='250' height='250' title='Sensor display with a selection box around a laser target' /> <br/>
6. wait for laser lockon beeping sound to change from a lower to a higher pitch <br/>
7. fire weapon (<font color='#00ffff'>%5</font>) <br/>
<br/>
For more info on other icons shown in this display check the <execute expression='[""Vehicle"", ""SensorDisplay""] call BIS_fnc_openFieldManual'>Sensor Display Field Manual</execute>. <br/>
<br/>
Be aware that you only have <font color='#00ffff'>%4 missle(s)</font> available. <br/>
So use them carefully for high-value targets. <br/>
", _ReconLink, actionName "vehLockTargets", actionKeysNames "vehLockTargets", 
_myVLS ammo "weapon_VLS_01", actionKeysNames "defaultAction", _ArtiLink, _MortarLink, 
rank player, _VLSauthorized] + _back2IntroLink]];


// Drone jammer
private _JammerEffectiveRadius = demo_jammer getVariable "EffectiveRadius";
private _JammerFalloffRadius = demo_jammer getVariable "FalloffRadius";
player setDiaryRecordText [["shootnscoot_diarySubject", _OmniJammerRecord], ["Drone jammer", format [
"<font color='#D18D1F' size='16'>Drone jammer (area denial)</font> <br/>
The <font color='#00ffff'>area denial anti drone jammer</font> is a box that can be turned on and off. <br/>
<img src='pics\omni_jammer_box.jpg' width='370' height='370' title='Drone jammer box' /> 
(activate and de-activate via Vanilla mouse-scroll menu) <br/>
<br/>
When activated it <font color='#00ffff'>distorts the video feed</font> for the drone pilots in a <font color='#00ffff'>radius of %1m</font> around/above the jammer. <br/>
<img src='pics\distorted_video_feed.jpg' width='370' height='370' title='Distorted video signal' /> 
This makes aerial %2 difficult or impossible (dependent on how close the drone is to the jammer). <br/>
<br/>
The drone will suffer a <font color='#ff00ff'>softkill at a distance of &lt;%3m</font> to the jammer. <br/>
- pilots get disconnected <br/>
- drone is forced to stop moving and slowly land <br/>
<br/>
Note: <br/>
- jammer <font color='#00ffff'>effects both enemy and friendly drones</font> <br/>
- radiuses are 3D (meaning drone altitude also counts)<br/>
- UGVs are also effected by the jammer <br/>
<br/>
Transportation: <br/>
- <font color='#00ffff'>ACE carrying and vic loading are supported</font> <br/>
- box deactivates when being loaded <br/>
- takes 1x ACE cargo space  <br/>
  (fits even into light vics of %4 when spare wheel is removed) <br/>
<br/>
Bugs: <br/>
- unloading takes 3-6s before box appears <br/>
- box is indestructible (but will die along with a vic when loaded) <br/>
- not subject to gravity (when deployed off ground it stays in the air)<br/>
", (_JammerEffectiveRadius + _JammerFalloffRadius), _ReconLink, _JammerEffectiveRadius, _HunterLink] + _back2IntroLink]];


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
player setDiaryRecordText [["shootnscoot_diarySubject", _WorkaroundsRecord], ["Workarounds", _MortarUnloadWorkaround + _DroneAIWorkaround + _ChangeSeatWorkaround]];


// select top-most entry at game start
player selectDiarySubject "shootnscoot_diarySubject:Record-1";
