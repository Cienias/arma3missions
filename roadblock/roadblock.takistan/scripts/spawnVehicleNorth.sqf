randomCivilianClass = compile preprocessFile "scripts\randomCivilian.sqf";
randomVehicleClass = compile preprocessFile "scripts\randomVehicle.sqf";

_civilianRandomClass = [] call randomCivilianClass;
_vehicleRandomClass = [] call randomVehicleClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;
systemchat format ['Spawn: %1', _posSpawnString];

_posDest = if (_posSpawnString == "spawn_south_0" || _posSpawnString == "spawn_south_1") then {
	 getMarkerPos "checkpoint_stop_south"} else {
		  getMarkerPos "checkpoint_stop_north"};

_vehicle = _vehicleRandomClass createVehicle _posSpawn;
_maxCargo = _vehicle emptyPositions "Cargo";
_passengerCount = random _maxCargo;

_grpCiv = createGroup [civilian, true];
_civilian1 = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;

for "_passengerCount" from 1 to _passengerCount do {
	_civilianRandomClass = [] call randomCivilianClass;
	_x = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
	_x moveInCargo _vehicle;
};

_grpCiv addWaypoint [_posDest, 0];