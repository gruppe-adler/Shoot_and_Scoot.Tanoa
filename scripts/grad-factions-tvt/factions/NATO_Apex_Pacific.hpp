class NATO_Apex_Pacific {
    class AllUnits {
        uniform = "U_B_T_Soldier_AR_F";
        vest = "V_Chestrig_rgr";
        backpack = "";
        headgear = "H_HelmetB_Light_tna_F";
        primaryWeapon = "";
        primaryWeaponMagazine = "";
        primaryWeaponMuzzle = "";
        primaryWeaponOptics = "";
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
        handgunWeapon = "";
        handgunWeaponMagazine = "";
        handgunWeaponMuzzle = "";
        handgunWeaponOptics = "";
        handgunWeaponPointer = "";
        handgunWeaponUnderbarrel = "";
        handgunWeaponUnderbarrelMagazine = "";
        goggles = "";
        nvgoggles = "";
        radio = "TFAR_anprc152";
        binoculars = "Binocular";
        map = "ItemMap";
        gps = "ItemGPS";
        compass = "ItemCompass";
        addItemsToUniform[] = {
            MEDICITEMS_BASE,
            LIST_2("ACE_Chemlight_HiWhite"),
            "ACE_Flashlight_MX991",
            "ACE_MapTools"
          };
        addItemsToBackpack[] = {};
    };

    class Type {
        class Support_Mort_F {
            uniform = "U_B_T_Soldier_AR_F";
            vest = "V_Chestrig_rgr";
            headgear = "H_HelmetB_Light_tna_F";
            primaryWeapon = "arifle_MXC_khk_Holo_Pointer_F";
            primaryWeaponMagazine = "30Rnd_65x39_caseless_khaki_mag";
            primaryWeaponOptics = "optic_Holosight_khk_F";
            primaryWeaponPointer = "acc_pointer_IR";
            primaryWeaponMuzzle = "";
            primaryWeaponUnderbarrel = "";
            handgunWeapon = "hgun_P07_khk_F";
            handgunWeaponMagazine = "16Rnd_9x21_Mag";
            handgunWeaponOptics = "";
            handgunWeaponPointer = "";
            handgunWeaponMuzzle = "";
            handgunWeaponUnderbarrel = "";
            map = "ItemMap";
            compass = "ItemCompass";
            watch = "ItemWatch";
            gps = "";
            radio = "ItemRadio";
            nvgoggles = ""; // "NVGoggles_tna_F";
            addItemsToUniform[] = {
                LIST_1("FirstAidKit"),
                LIST_2("30Rnd_65x39_caseless_khaki_mag")

                GRAD_FACTIONS_MEDICITEMS_INF_LIST
            };
            addItemsToVest[] = {
                LIST_5("30Rnd_65x39_caseless_khaki_mag"),
                LIST_2("16Rnd_9x21_Mag"),
                LIST_2("HandGrenade"),
                LIST_2("B_IR_Grenade"),
                LIST_1("SmokeShell"),
                LIST_1("SmokeShellGreen"),
                LIST_2("Chemlight_green")
            };
        };
    };
};
