randomCivilianIDAPClass = compile preprocessFile "scripts\configs\randomCivilianIDAP.sqf";
randomVehicleIDAPClass = compile preprocessFile "scripts\configs\randomVehicleIDAP.sqf";
randomCargoMedicineClass = compile preprocessFile "scripts\configs\randomCargoMedicine.sqf";

_civilianRandomClass = [] call randomCivilianIDAPClass;
_vehicleRandomClass = [] call randomVehicleIDAPClass;
_cargoMedicineRandomClass = [] call randomCargoMedicineClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;

_randomCargoAmount = random 25;

_posDestCheckpoint = _posSpawn;
_posDestFinal = _posSpawn;

if (_posSpawnString == "spawn_south_0" || _posSpawnString == "spawn_south_1") then {
	 _posDestCheckpoint = getMarkerPos "checkpoint_stop_south_0";
	 _posDestFinal = getMarkerPos selectRandom ["spawn_north_0", "spawn_north_1"];
	 } else {
			_posDestCheckpoint = getMarkerPos "checkpoint_stop_north_0";
			_posDestFinal = getMarkerPos selectRandom ["spawn_south_0", "spawn_south_1"];
		  };

_grpCiv = createGroup [civilian, true];
_grpCiv deleteGroupWhenEmpty true;

_vehicle = _vehicleRandomClass createVehicle _posSpawn;
_maxCargo = _vehicle emptyPositions "Cargo";
_passengerCount = random _maxCargo;

_grpCiv addVehicle _vehicle;


for "_i" from 0 to _randomCargoAmount do {
	_randomItem = [] call randomCargoMedicineClass;
	_vehicle addItemCargoGlobal [_randomItem,1];
};

_civilian1 = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;

for "_i" from 1 to _passengerCount do {
	_civilianRandomClass = [] call randomCivilianIDAPClass;
	_x = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
	_x moveInCargo _vehicle;
};

_vehicle setVariable ["vehicleSpawn", _posSpawn, true];
_vehicle setVariable ["vehicleDestinationFinal", _posDestFinal, true];
_vehicle setVariable ["vehicleGroup", _grpCiv, true];

//_vehicle remoteExec ["scipts\addOrderMultiplayer.sqf", 0, true];
[[_vehicle],'scripts\orderMulti.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
[[_vehicle],'scripts\removeVehicleAction.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];

_grpCiv addWaypoint [_posDestCheckpoint, 0];
