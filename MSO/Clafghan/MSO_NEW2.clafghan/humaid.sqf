_grphumaid = createGroup civilian;
_grphumaidleader = createGroup civilian;
_pos = getpos PH1; 

_box = "CargoNet_01_box_F" createVehicle position PH1; 
// _markerPos = getMarkerPos "PH1Marker";
PH1 setpos getMarkerPos "PH1Marker"; 

_unit1 = _grphumaidleader createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"]; 
_unit2 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit2 doMove (position _box);
_unit3 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit3 doMove (position _box);
_unit4 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit4 doMove (position _box);
_unit5 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit5 doMove (position _box);
_unit6 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit6 doMove (position _box);
_unit7 = _grphumaid createUnit ["LOP_Tak_Civ_Man_01", _pos, [], 200, "FORM"];
_unit7 doMove (position _box);

sleep 120;

[getPos _box, [side player], -20] call ALIVE_fnc_updateSectorHostility;
deletevehicle _box;
_unit1 doMove (position _unit1);
_unit2 doMove (position _unit1);
_unit3 doMove (position _unit1);
_unit4 doMove (position _unit1);
_unit5 doMove (position _unit1);
_unit6 doMove (position _unit1);

sleep 40;

{deletevehicle _x} forEach (units _grphumaid);
deleteGroup _grphumaid