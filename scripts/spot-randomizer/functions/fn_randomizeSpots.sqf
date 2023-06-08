private _numPossiblePositions = 20;   // How many possible positions for supply stations are there (per side)?
private _numActualStations    = 5;    // How many of the possible positions will acutally have supply stations?

// fetch all markers
private _bluforAllMarkers = [];
private _opforAllMarkers = []; 
for "_i" from 1 to _numPossiblePositions do {
    private _string = format ["blufor_pos%1", _i];
    _bluforAllMarkers pushBackUnique _string;
    
    _string = format ["opfor_pos%1", _i];
    _opforAllMarkers pushBackUnique _string;
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
    [west,     _x, getMarkerPos _x] call spot_randomizer_fnc_placeTask;
    [civilian, _x, getMarkerPos _x] call spot_randomizer_fnc_placeTask;   // for Zeus' convenience
} forEach _bluforStations;
{
    [east,     _x, getMarkerPos _x] call spot_randomizer_fnc_placeTask;
    [civilian, _x, getMarkerPos _x] call spot_randomizer_fnc_placeTask;   // for Zeus' convenience
} forEach _opforStations;
