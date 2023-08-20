params ["_originatorPos", "_falseHeading", "_interceptPos", "_shotKey"];

systemChat "Artillery shot detected! Drawing on map!";

call arsr_fnc_drawLines;
