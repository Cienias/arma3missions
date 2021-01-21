randomCivilianClass = compile preprocessFile "scripts\randomCivilian.sqf";
randomVehicleClass = compile preprocessFile "scripts\randomVehicle.sqf";

_civilianRandomClass = [] call randomCivilianClass;
_vehicleRandomClass = [] call randomVehicleClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;
systemchat format ['Spawn: %1', _posSpawnString];
_posDestCheckpoint = _posSpawn;
_posDestFinal = _posSpawn;

if (_posSpawnString == "spawn_south_0" || _posSpawnString == "spawn_south_1") then {
	 _posDestCheckpoint = getMarkerPos "checkpoint_stop_south";
	 _posDestFinal = getMarkerPos selectRandom ["spawn_north_0", "spawn_north_1"];
	 } else {
			_posDestCheckpoint = getMarkerPos "checkpoint_stop_north";
			_posDestFinal = getMarkerPos selectRandom ["spawn_south_0", "spawn_south_1"];
		  };



_grpCiv = createGroup [civilian, true];

_vehicle = _vehicleRandomClass createVehicle _posSpawn;
_maxCargo = _vehicle emptyPositions "Cargo";
_passengerCount = random _maxCargo;

_grpCiv addVehicle _vehicle;

_civilian1 = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;

for "_passengerCount" from 1 to _passengerCount do {
	_civilianRandomClass = [] call randomCivilianClass;
	_x = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
	_x moveInCargo _vehicle;
};


_vehicle setVariable ["vehicleSpawn", _posSpawn, true];
_vehicle setVariable ["vehicleDestinationFinal", _posDestFinal, true];
_vehicle setVariable ["vehicleGroup", _grpCiv, true];

_aceInteractionGo = ["Interactions", "You can go", "", {[_target, "go"]execVM "scripts\order.sqf";}, {true}] call ace_interact_menu_fnc_createAction;
_aceInteractionTurnAround = ["Interactions", "Turn around", "", {[_target, "turnAround"]execVM "scripts\order.sqf";}, {true}] call ace_interact_menu_fnc_createAction; 

[_vehicle, 0, ["ACE_MainActions"], _aceInteractionGo] call ace_interact_menu_fnc_addActionToObject;
[_vehicle, 0, ["ACE_MainActions"], _aceInteractionTurnAround] call ace_interact_menu_fnc_addActionToObject;

_grpCiv addWaypoint [_posDestCheckpoint, 0];