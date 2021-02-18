randomFighterClass = compile preprocessFile "scripts\configs\randomFighter.sqf";

_posSpawnString = selectRandom ["attack_0", "attack_1", "attack_2", "attack_3", "attack_4"];
_posSpawn = getMarkerPos _posSpawnString;
_fighterRandomClass = [] call randomFighterClass;

_posDestCheckpoint = getMarkerPos "checkpoint_center";



_fighterAmount = random 12;

_grpFighters = createGroup [east, true];
_grpFighters deleteGroupWhenEmpty true;

_fighter1 = _grpFighters createUnit [_fighterRandomClass, _posSpawn, [], 0, "NONE"];

for "_i" from 1 to _fighterAmount do {
	_fighterRandomClass = [] call randomFighterClass;
	_x = _grpFighters createUnit [_fighterRandomClass, _posSpawn, [], 0, "NONE"];
};

_waypointFinal = _grpFighters addWaypoint [_posDestCheckpoint,0];