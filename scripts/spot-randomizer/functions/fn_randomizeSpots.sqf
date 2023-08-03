if (!isServer) exitWith {};   // we don't want this to run on the clients

private _numPossiblePositions = 20;   // How many possible positions for supply stations are there (per side)?
private _numActualStations    = 5;    // How many of the possible positions will acutally have supply stations?

is_Zeus = !isNull (getAssignedCuratorLogic player);
if (is_Zeus) then { systemChat "Randomizing spots started"; };

// fetch all markers
private _bluforAllMarkers = [];
private _opforAllMarkers = [];
for "_i" from 1 to _numPossiblePositions do {
    private _string = format ["blufor_pos%1", _i];
    _bluforAllMarkers pushBackUnique _string;

    _string = format ["opfor_pos%1", _i];
    _opforAllMarkers pushBackUnique _string;
};


// sort markers by x-coordinate
private _bluforAllMarkersSorted = [ _bluforAllMarkers, [], { getMarkerPos _x select 0 }, "ASCEND" ] call BIS_fnc_sortBy;
private _opforAllMarkersSorted  = [ _opforAllMarkers,  [], { getMarkerPos _x select 0 }, "ASCEND" ] call BIS_fnc_sortBy;
// rename markers from West to East with ascending numbers
for "_i" from 1 to _numPossiblePositions do {
    (_bluforAllMarkersSorted select _i-1) setMarkerText (format [" Blue %1", _i]);
    (_opforAllMarkersSorted  select _i-1) setMarkerText (format [" Red %1",  _i]);
};


// select random stations with the actual containers being present
private _bluforStations = [];
private _opforStations = [];
for "_i" from 1 to _numActualStations do {
    private _bluforSpot = selectRandom _bluforAllMarkers;
    _bluforStations pushBackUnique _bluforSpot;
    _bluforAllMarkers deleteAt (_bluforAllMarkers find _bluforSpot);

    private _opforSpot = selectRandom _opforAllMarkers;
    _opforStations pushBackUnique _opforSpot;
    _opforAllMarkers deleteAt (_opforAllMarkers find _opforSpot);
};


// create tasks for both sides that show them their own stations
{
    [west,     _x] call spot_randomizer_fnc_placeTask;
    [civilian, _x] call spot_randomizer_fnc_placeTask;   // for Zeus' convenience
    // [independent, _x] call spot_randomizer_fnc_placeTask;   // for streamer convenience
} forEach _bluforStations;
{
    [east,     _x] call spot_randomizer_fnc_placeTask;
    [civilian, _x] call spot_randomizer_fnc_placeTask;   // for Zeus' convenience
    // [independent, _x] call spot_randomizer_fnc_placeTask;   // for streamer convenience
} forEach _opforStations;


// create supply stations for both sides
{
    [west, _x] call spot_randomizer_fnc_placeSupplyStation;
    if (is_Zeus) then { systemChat (["BluFor spot placed at",_x] joinString " "); };
} forEach _bluforStations;
{
    [east, _x] call spot_randomizer_fnc_placeSupplyStation;
    if (is_Zeus) then { systemChat (["OpFor spot placed at",_x] joinString " "); };
} forEach _opforStations;

if (is_Zeus) then { systemChat "Randomizing spots done"; };
