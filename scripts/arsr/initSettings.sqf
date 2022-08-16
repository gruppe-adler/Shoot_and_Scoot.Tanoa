// ========= General =========

[
    "arsr_speedOfSound",
    "SLIDER",
    ["Speed of sound", "Speed of sound in meters per second. Higher means faster detection, lower means slower detection. 0 means instant. Not really recommended to change unless you want to change how physics work"],
    ["Mission", "ARSR - General"],
    [0, 2000, 343, 2],
    true
] call CBA_fnc_addSetting;

[
    "arsr_artilleryBaseClassesSetting",
    "EDITBOX",
    ["Artillery classes", "The classes of artillery that should be listened to, including all inheriting classes!"],
    ["Mission", "ARSR - General"],
    "[""B_MBT_01_arty_F"",""MBT_02_arty_base_F""]",
    true
] call CBA_fnc_addSetting;

[
    "arsr_listenerClassesSetting",
    "EDITBOX",
    ["Listener classes", "The classes of vehicles that should be listening, no inheritance!"],
    ["Mission", "ARSR - General"],
    "[""B_Truck_01_ammo_F""]",
    true
] call CBA_fnc_addSetting;

[
    "arsr_approxymationMarker",
    "CHECKBOX",
    ["Show approxymation marker", "Shows a marker that uses the inaccurate location info to show an approximate position of the artillery piece. This marker will NOT be auto deleted!"],
    ["Mission", "ARSR - General"],
    true,
    true
] call CBA_fnc_addSetting;

if !(isNil "ace_explosives") then {
    [
        "arsr_allowPlacedExplosives",
        "CHECKBOX",
        ["Allow placed explosives as fake artillery shots", "Will make placed explosives count as fake artillery. Useful for TvTs as diversions and to cause confusion"],
        ["Mission", "ARSR - General"],
        false,
        true
    ] call CBA_fnc_addSetting;

    [
        "arsr_explosivesAddSide",
        "CHECKBOX",
        ["Add side info for explosives", "Adds information of the player side that placed the explosive"],
        ["Mission", "ARSR - General"],
        true,
        true
    ] call CBA_fnc_addSetting;

    [
        "arsr_explosivesMinHit",
        "SLIDER",
        ["Minimum hit value of explosives'", "Uses the ""hit"" value of the explosive to determine if the eplosion is large enough. For reference; demolition blocks are 500 hit, small IEDs are 200 hit, large IEDs are 2000 hit"],
        ["Mission", "ARSR - General"],
        [0, 2000, 500, 0],
        true
    ] call CBA_fnc_addSetting;
} else {
    arsr_explosivesAddSide = false;
    arsr_allowPlacedExplosives = false;
    arsr_explosivesAddSide = 0;
};

// ========= User settings =========

[
    "arsr_drawStyle",
    "LIST",
    ["Draw style", "Style how the listener data is being displayed"],
    ["Mission", "ARSR - User settings"],
    [[0, 1, 2], ["Arrows", "Lines", "Cones"], 1],
    false
] call CBA_fnc_addSetting;

[
    "arsr_autoDeleteMarkerTime",
    "SLIDER",
    ["Auto delete Markers", "Time in seconds, -1 means disabled"],
    ["Mission", "ARSR - User settings"],
    [-1, 10*60, -1, 0],
    false
] call CBA_fnc_addSetting;

private _colors = "true" configClasses (configFile >> "CfgMarkerColors") apply {configName _x};
private _indexRed = _colors findIf {_x isEqualTo "ColorRed"};
private _indexBlue = _colors findIf {_x isEqualTo "ColorBlue"};
[
    "arsr_markerColor",
    "LIST",
    ["Marker color", "Color of markers like crosses or arrows"],
    ["Mission", "ARSR - User settings"],
    [_colors, _colors, _indexRed],
    false
] call CBA_fnc_addSetting;

[
    "arsr_lineColor",
    "LIST",
    ["Line color", "Color of drawn lines"],
    ["Mission", "ARSR - User settings"],
    [_colors, _colors, _indexBlue],
    false
] call CBA_fnc_addSetting;

// ========= Listener =========

[
    "arsr_listenerCalcDelay",
    "SLIDER",
    ["Time to calculate for listener", "The time that a listener will take between hearing a shot fired, and displaying the direction"],
    ["Mission", "ARSR - Listener"],
    [0, 120, 20, 0],
    true
] call CBA_fnc_addSetting;

[
    "arsr_vicStationary",
    "CHECKBOX",
    ["Listener must be stationary", "Listener must completely stand still in otdfer to listen"],
    ["Mission", "ARSR - Listener"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "arsr_vicEngineOff",
    "CHECKBOX",
    ["Listener engine must be off", "Only allow ranging if the vehicles engine is off"],
    ["Mission", "ARSR - Listener"],
    true,
    true
] call CBA_fnc_addSetting;

[
    "arsr_listenerAccuracy",
    "SLIDER",
    ["Listener accuracy", "Value in meters, higher values mean less accurate"],
    ["Mission", "ARSR - Listener"],
    [0, 1000, 50, 0],
    true
] call CBA_fnc_addSetting;

[
    "arsr_listenerMaxDistance",
    "SLIDER",
    ["Listener max listening distance", "Value in meters, how far can listener vehicle detect shots"],
    ["Mission", "ARSR - Listener"],
    [0, 10000, 10000, 0],
    true
] call CBA_fnc_addSetting;

