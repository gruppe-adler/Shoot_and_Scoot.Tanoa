force ace_advanced_fatigue_loadFactor = 0.75;
force ace_advanced_fatigue_performanceFactor = 1.3;
force ace_advanced_fatigue_recoveryFactor = 1.1;

force ace_hearing_autoAddEarplugsToUnits = false;
force ace_hearing_disableEarRinging = true;
force ace_hearing_enableCombatDeafness = false;
force ace_hearing_enabledForZeusUnits = false;

force ace_repair_engineerSetting_fullRepair = 1;
force ace_repair_engineerSetting_repair = 0;
force ace_repair_fullRepairLocation = 0;

force ace_map_BFT_Enabled = true;	// do be set to false before release
force ace_map_BFT_Interval = 3;
force ace_map_mapShowCursorCoordinates = true;

force ace_medical_AIDamageThreshold = 0.8;
force ace_medical_bleedingCoefficient = 1.0;
force ace_medical_fractures = 0;
force ace_medical_painCoefficient = 1;
force ace_medical_playerDamageThreshold = 1.3;
force ace_medical_treatment_advancedBandages = false;
force ace_medical_treatment_advancedDiagnose = false;
force ace_medical_treatment_advancedMedication = false;
force ace_medical_treatment_allowSelfIV = 0;
force ace_medical_treatment_clearTraumaAfterBandage = true;
force ace_medical_ai_enabledFor = 2;
force ace_medical_blood_enabledFor = 2;
force ace_medical_fatalDamageSource = 2;
force ace_medical_fractureChance = 0.8;
force ace_medical_limping = 1;
force ace_medical_spontaneousWakeUpChance = 0.15;
force ace_medical_spontaneousWakeUpEpinephrineBoost = 3;
force ace_medical_statemachine_cardiacArrestTime = 30;
force ace_medical_statemachine_fatalInjuriesAI = 0;
force ace_medical_statemachine_fatalInjuriesPlayer = 0;
force ace_medical_treatment_advancedBandages = 0;
force ace_medical_treatment_holsterRequired = 0;
force ace_medical_treatment_locationEpinephrine = 0;
force ace_medical_treatment_medicEpinephrine = 0;
force ace_medical_treatment_medicIV = 1;
force ace_medical_treatment_allowSelfIV = 1;  // Medics can Self-IV

// usage of PAKs
force ace_medical_treatment_consumePAK = 1;   // PAKs are consumable items
force ace_medical_treatment_medicPAK = 1;     // Medics can use PAKs
force ace_medical_treatment_allowSelfPAK = 1; // Medics can Self-PAK
force ace_medical_treatment_locationPAK = 0;  // allow to use PAK anywhere


force ace_finger_enabled = true;

force ace_vehiclelock_lockVehicleInventory = true;

force ace_viewdistance_limitViewDistance = 8000;

force ace_weather_enabled = false;
force ace_weather_windSimulation = false;

// TFAR - Global settings
force TFAR_globalRadioRangeCoef = 2;	// increase radio range 
force TFAR_SameSRFrequenciesForSide = true;
force TFAR_SameLRFrequenciesForSide = true;
force TFAR_setting_defaultFrequencies_lr_west = "31,32,33,34,35,36,37,38";
force TFAR_setting_defaultFrequencies_lr_east = "71,72,73,74,75,76,77,78";
force TFAR_setting_defaultFrequencies_sr_west = "301,302,303,304,305,306,307,308";
force TFAR_setting_defaultFrequencies_sr_east = "381,382,383,384,385,386,387,388";


// ACE Crew Served Weapons
force ace_csw_ammoHandling = 0;


// ACE Logistics
force ace_cargo_carryAfterUnload = true;
force ace_cargo_loadTimeCoefficient = 10;   // defaults to 5; increased to slow down mortar vehicles
force ace_rearm_supply = 1; // rearm supply is limited (using credits)
force ace_rearm_level = 1;  // rearm types of ammo separately (not entire vic at once)
force ace_towing_addRopeToVehicleInventory = false;  // prevent towing arti with the towing rope

// Artillery Sound Ranging
force arsr_allowPlacedExplosives = false;
force arsr_artilleryBaseClassesSetting = "[""RHS_M119_WD""], [""rhssaf_army_o_d30""], [""APC_Wheeled_01_mortar_base_lxWS""], [""B_D_APC_Wheeled_01_mortar_lxWS""], [""B_T_APC_Wheeled_01_mortar_lxWS""], [""O_Mortar_01_F""], [""B_Mortar_01_F""], [""B_T_Mortar_01_F""], [""B_D_Mortar_01_lxWS""]";
force arsr_autoDeleteMarkerTime = 40;	// in seconds
force arsr_explosivesAddSide = true;
force arsr_explosivesMinHit = 500;
force arsr_angleError = 3;	// in degree (as passed into "random [min, mid, max]")
force arsr_listenerCalcDelay = 0;	// default 20
force arsr_listenerClassesSetting = "[""UK3CB_CHD_O_Gaz66_Radio"", ""UK3CB_CHD_W_B_Gaz66_Radio""]";
force arsr_listenerMaxDistance = 20000;	// in meters
arsr_markerColor = "Default";
force arsr_speedOfSound = 1500; // realistic sound traveling time would be 343 (but this is to slow for good counter battery action)
force arsr_vicEngineOff = true;
force arsr_vicStationary = true;

// Crows Electronic Warfare
force crowsEW_spectrum_spectrumEnable = true;	// enable Spectrum Device
force crowsEW_spectrum_selfTracking = true;		// show own radio emissions
force crowsEW_spectrum_tfarSideTrack = true;	// show friendly radio emissions
force crowsEW_spectrum_minJamSigStrength = -50;	// (in dBm); minimum signal strength necessary in Spectrum Device for jamming
