_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;

_randomCargoAmount = random 25;
_randomCargoContrabandProb = random 10;


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

_vehicle = "UK3CB_TKC_C_SUV" createVehicle _posSpawn;
_maxCargo = _vehicle emptyPositions "Cargo";
_passengerCount = random _maxCargo;

_grpCiv addVehicle _vehicle;

_civilian1 = _grpCiv createUnit ["UK3CB_CHC_C_POLITIC", _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;

for "_i" from 1 to _passengerCount do {
	_x = _grpCiv createUnit ["UK3CB_CHC_C_BODYG", _posSpawn, [], 0, "NONE"];
	_x moveInCargo _vehicle;
};

_vehicle setVariable ["vehicleSpawn", _posSpawn, true];
_vehicle setVariable ["vehicleDestinationFinal", _posDestFinal, true];
_vehicle setVariable ["vehicleGroup", _grpCiv, true];

[[_vehicle],'scripts\orderMulti.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
[[_vehicle],'scripts\removeVehicleAction.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];

_grpCiv addWaypoint [_posDestCheckpoint, 0];