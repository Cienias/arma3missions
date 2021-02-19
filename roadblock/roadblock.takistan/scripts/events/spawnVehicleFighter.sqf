randomVehicleClass = compile preprocessFile "scripts\configs\randomVehicle.sqf";
randomFighterClass = compile preprocessFile "scripts\configs\randomFighter.sqf";

_fighterRandomClass = [] call randomFighterClass;
_vehicleRandomClass = [] call randomVehicleClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;

_posDestCheckpoint = _posSpawn;
_posDestFinal = _posSpawn;

if (_posSpawnString == "spawn_south_0" || _posSpawnString == "spawn_south_1") then {
	 _posDestCheckpoint = getMarkerPos "checkpoint_stop_south_1";
	 _posDestFinal = getMarkerPos selectRandom ["spawn_north_0", "spawn_north_1"];
	 } else {
			_posDestCheckpoint = getMarkerPos "checkpoint_stop_north_1";
			_posDestFinal = getMarkerPos selectRandom ["spawn_south_0", "spawn_south_1"];
		  };

_grpFighters = createGroup [east, true];
_grpFighters deleteGroupWhenEmpty true;

_vehicle = _vehicleRandomClass createVehicle _posSpawn;
_maxCargo = _vehicle emptyPositions "Cargo";
_passengerCount = random _maxCargo;

_grpFighters addVehicle _vehicle;

_fighter1 = _grpFighters createUnit [_fighterRandomClass, _posSpawn, [], 0, "NONE"];
_fighter1 moveInDriver _vehicle;

for "_i" from 1 to _passengerCount do {
	_fighterRandomClass = [] call randomFighterClass;
	_x = _grpFighters createUnit [_fighterRandomClass, _posSpawn, [], 0, "NONE"];
	_x moveInCargo _vehicle;
};

_grpFighters addWaypoint [_posDestCheckpoint, 0];
_nextWaypoint = selectRandom [_posDestFinal, getMarkerPos "checkpoint_center"];
_grpFighters addWaypoint [_nextWaypoint,0];
_waypointFinal = _grpFighters addWaypoint [_posDestFinal,0];
//_waypointFinal setWaypointStatements ["true", "{doGetOut _x} forEach thisList; {deleteVehicle _x} forEach thisList; deleteVehicle this;"];
_waypointFinal setWaypointStatements ["true", "{doGetOut _x} forEach thisList; deleteVehicle this;"];

[[_vehicle],'scripts\removeVehicleAction.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];