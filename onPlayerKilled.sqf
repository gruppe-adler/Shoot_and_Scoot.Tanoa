params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];


// Kotomo bridge is a bit more than 8km away from the Opfor base near Saint-Paul.
// An AI in a prowler takes 8:30 min from bridge to base.
// Thus the respawn time penalty is set to be about 1min per 1km distance from point of dying to respawn point
private _respawnPoint = switch (playerSide) do
{
	case west:        { blufor_respawn      };
	case east:        { opfor_respawn       };
	case civilian:    { civilian_respawn    }; 
	case independent: { independent_respawn }; 
};
private _distance = (_oldUnit distance2D _respawnPoint);
private _timePenalty = if (playerSide == civilian || playerSide == independent) then { 
                              0;   // no time penalty for respawning Zeus
                          } else { 
                              _distance/1000 * 30;  // 30s per 1km distance
                          };
setPlayerRespawnTime _timePenalty;

 if (_timePenalty > 0) then { 
    hint parseText format ["You died <t color='#ff0000'>%1km</t> away from your respawn point. %2
    Thus your respawn time is set to <t color='#ff0000'>%3min %4s</t>. %5
    <t color='#00ffff'>The further away from home you die,  %6
    the longer you need to wait.</t>", (_distance/1000) toFixed 1, "<br/><br/>", floor (_timePenalty/60), (_timePenalty%60) toFixed 0, "<br/><br/>", "<br/>"];
};
