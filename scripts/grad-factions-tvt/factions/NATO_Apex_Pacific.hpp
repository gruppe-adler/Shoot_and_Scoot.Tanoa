class NATO_Apex_Pacific {
    class AllUnits {
        uniform = "U_B_T_Soldier_AR_F";
        vest = "V_Chestrig_rgr";
        backpack = "";
        headgear = "H_HelmetB_Light_tna_F";
        primaryWeapon = "";
        primaryWeaponMagazine = "";
        primaryWeaponOptics = "";
        primaryWeaponMuzzle = "";
        primaryWeaponPointer = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";
        secondaryWeapon = "";
        secondaryWeaponMagazine = "";
        secondaryWeaponMuzzle = "";
        secondaryWeaponOptics = "";
        secondaryWeaponPointer = "";
        secondaryWeaponUnderbarrel = "";
        secondaryWeaponUnderbarrelMagazine = "";
        handgunWeapon = "hgun_P07_khk_F";
        handgunWeaponMagazine = "16Rnd_9x21_Mag";
        handgunWeaponMuzzle = "";
        handgunWeaponOptics = "";
        handgunWeaponPointer = "";
        handgunWeaponUnderbarrel = "";
        handgunWeaponUnderbarrelMagazine = "";
        goggles = "";
        nvgoggles = ""; // "NVGoggles_tna_F";
        radio = "TFAR_anprc152";
        binoculars = "Binocular";
        map = "ItemMap";
        gps = "ItemGPS";
        compass = "ItemCompass";
        watch = "ItemWatch";
        addItemsToUniform[] = {
            MEDICITEMS_BASE,
            LIST_2("ACE_Chemlight_HiWhite"),
            // "ACE_Flashlight_MX991",
            "ACE_MapTools"
          };
        addItemsToVest[] = {
            LIST_2("16Rnd_9x21_Mag"),
            LIST_1("SmokeShell"),
            LIST_1("SmokeShellGreen"),
            LIST_2("Chemlight_green")
        };
        addItemsToBackpack[] = {};
    };

    class Type {
        // rifleman
        class Soldier_F {
            uniform = "U_B_T_Soldier_F";
            vest = "V_PlateCarrier1_tna_F";
            primaryWeapon = "arifle_MX_khk_ACO_Pointer_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_Aco";
            addItemsToVest[] = {
                LIST_7("30Rnd_65x39_caseless_khaki_mag"),
                LIST_2("HandGrenade")
            };
        };

        // artillery gunner
        class Support_Mort_F {
            primaryWeapon = "arifle_MXC_khk_Holo_Pointer_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_Holosight_khk_F";
            goggles = "G_Tactical_Clear";
            addItemsToVest[] = {
                LIST_5("30Rnd_65x39_caseless_khaki_mag")
            };
        };
        
        // marksman
        class soldier_M_F: Soldier_F {
            uniform = "U_B_T_Soldier_F";
            vest = "V_PlateCarrier1_tna_F";
            headgear = "H_HelmetB_tna_F";
            primaryWeapon = "arifle_MXM_khk_MOS_Pointer_Bipod_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_SOS_khk_F";
            primaryWeaponPointer = "";
            primaryWeaponMuzzle = "";
            primaryWeaponUnderbarrel = "bipod_01_F_khk"
        };
    };
};
