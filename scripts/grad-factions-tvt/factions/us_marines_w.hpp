class us_marines_w {
    class AllUnits {
        primaryWeapon = "rhs_weap_m16a4";
        primaryWeaponMagazine = "rhs_mag_30Rnd_556x45_M855A1_Stanag";
        primaryWeaponMuzzle = "";
        primaryWeaponOptics[] = {
            "rhsusf_acc_eotech_xps3",
            "rhsusf_acc_T1_high",
            "rhsusf_acc_eotech_552"
        };
        primaryWeaponPointer = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";
        secondaryWeapon = "";
        secondaryWeaponMagazine = "";
        handgunWeapon = "rhsusf_weap_m9";
        handgunWeaponMagazine = "rhsusf_mag_15Rnd_9x19_JHP";
        uniform = "rhs_uniform_FROG01_wd";
        vest = "rhsusf_spc_rifleman";
        backpack = "";
        headgear = "rhsusf_lwh_helmet_marpatwd";
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
        //rifleman
        class Soldier_F {
            addItemsToVest[] = {
                LIST_7("rhs_mag_30Rnd_556x45_M855A1_Stanag"),
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhsusf_mag_15Rnd_9x19_JHP"),
                LIST_2("rhs_mag_m67")
            };
        };

        //autorifleman
        class Soldier_AR_F: Soldier_F {
            primaryWeapon = "rhs_weap_m249";
            primaryWeaponMagazine = "rhsusf_200rnd_556x45_mixed_box";
            primaryWeaponOptics = "";
            handgunWeapon = "";
            handgunWeaponMagazine = "";
            vest = "rhsusf_spc_mg";
            backpack = "rhsusf_assault_eagleaiii_coy";
            addItemsToVest[] = {
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhs_mag_m67"),
                LIST_2("rhsusf_100Rnd_556x45_soft_pouch")
            };
            addItemsToBackpack[] = {
                LIST_3("rhsusf_200rnd_556x45_mixed_box")
            };
        };

        //light AT
        class Soldier_LAT_F: Soldier_F {
            secondaryWeapon = "rhs_weap_M136";
        };

        //ammo bearer
        class Soldier_A_F: Soldier_F {
            backpack = "rhsusf_assault_eagleaiii_coy";
            addItemsToBackpack[] = {
                LIST_3("rhsusf_200rnd_556x45_mixed_box")
            };
        };

        //assistant autorifleman
        class Soldier_AAR_F: Soldier_F {
            backpack = "rhsusf_assault_eagleaiii_coy";
            addItemsToBackpack[] = {
                LIST_3("rhsusf_200rnd_556x45_mixed_box")
            };
        };

        //medic
        class Medic_F: Soldier_F {
            vest = "rhsusf_iotv_ocp_Medic";
            backpack = "rhsusf_assault_eagleaiii_coy";
            addItemsToBackpack[] = {
                LIST_20("ACE_fieldDressing"),
                LIST_10("ACE_fieldDressing"),
                LIST_15("ACE_morphine"),
                LIST_15("ACE_epinephrine"),
                LIST_2("ACE_bloodIV_250")
            };
        };

        //squad leader
        class Soldier_SL_F: Soldier_F {
            vest = "rhsusf_spc_squadleader";
            backpack = "TFAR_rt1523g_rhs";
            headgear = "rhsusf_lwh_helmet_marpatwd_headset_blk2";
            addItemsToBackpack[] =  {
                LIST_2("rhs_mag_m18_green"),
                LIST_2("rhs_mag_m18_purple")
            };
        };

        //team leader
        class Soldier_TL_F: Soldier_F {
            primaryWeapon = "rhs_weap_m4a1_carryhandle_m203";
            vest = "rhsusf_spc_teamleader";
            headgear = "rhsusf_lwh_helmet_marpatwd_headset_blk2";
            addItemsToVest[] = {
                LIST_2("rhs_mag_an_m8hc"),
                LIST_2("rhs_mag_m67"),
                LIST_2("rhsusf_100Rnd_556x45_soft_pouch"),
                LIST_2("1Rnd_SmokeGreen_Grenade_shell"),
                LIST_2("1Rnd_SmokePurple_Grenade_shell"),
                LIST_2("1Rnd_SmokeRed_Grenade_shell")
            };
        };
    };

    class Rank {
        class LIEUTENANT {
            headgear = "rhs_8point_marpatwd";
            backpack = "TFAR_rt1523g_big";
        };
    };
};
