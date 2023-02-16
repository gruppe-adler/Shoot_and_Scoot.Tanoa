// generate random laser code for both sides
if (isServer) then {
    private _generateLaserCode = {
        private _code = "1" + (str floor random 8) + (str floor random 9) + (str floor random 9);
        parseNumber _code;
    };

    missionNamespace setVariable ["laserCode_bluefor", call _generateLaserCode, true];
    missionNamespace setVariable ["laserCode_opfor",   call _generateLaserCode, true];
};
diag_log ("laserCode_bluefor=" + str laserCode_bluefor);
diag_log ("laserCode_opfor=" + str laserCode_opfor);
