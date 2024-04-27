// CLIENT only!
if (!hasInterface) exitWith {};

// Only update for Zeus & Streamer
if (isNull(getAssignedCuratorLogic player)) exitWith {};
params ["_container", "_instigator", "_damage", "_ammo", "_damagePrv"];

private _dmg_dealt = (_damage - _damagePrv) * 100; // This var is in %

// Remember the last true damage dealing unit
if !(isNull(_instigator)) then {
    _container setVariable ["shootnscoot_lastDamageDealer", name _instigator];
};


// If regular damage, just show a message for Zeus&Streamer
if (_damage >= 1) exitWith {};  // Skip overkill from ACE cookoff event
if (_dmg_dealt < 3) exitWith {}; // Skip any tiny damage effects. These are probably just minor ACE frag damages.
systemChat format ["%1 dealt %2%3 damage to %4. Remaining HP %5%6", 
                        name _instigator, 
                        round _dmg_dealt, "%", 
                        markerText (_container getVariable "shootnscoot_stationid"), 
                        round ((1-_damage)*100), "%"
                    ];
