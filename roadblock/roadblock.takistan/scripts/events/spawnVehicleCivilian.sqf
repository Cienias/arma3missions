randomCivilianClass = compile preprocessFile "scripts\configs\randomCivilian.sqf";
randomVehicleClass = compile preprocessFile "scripts\configs\randomVehicle.sqf";
randomCargoLegalClass = compile preprocessFile "scripts\configs\randomCargoLegal.sqf";
randomCargoContrabandClass = compile preprocessFile "scripts\configs\randomCargoContraband.sqf";
randomMusicClass = compile preprocessFile "scripts\configs\randomMusic.sqf";

_civilianRandomClass = [] call randomCivilianClass;
_vehicleRandomClass = [] call randomVehicleClass;
_cargoLegalRandomClass = [] call randomCargoLegalClass;
_cargoContrabandRandomClass = [] call randomCargoContrabandClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;

_randomCargoAmount = random 25;
_randomCargoContrabandProb = random 10;

//systemchat format ['Spawn: %1', _posSpawnString];

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

if (_randomCargoContrabandProb > 8) then {
	for "_i" from 0 to _randomCargoAmount do {
		_randomItem = selectRandom [[] call randomCargoLegalClass, [] call randomCargoContrabandClass];
		_vehicle addItemCargo [_randomItem,1];
	};
} else {
		for "_i" from 0 to _randomCargoAmount do {
		_randomItem = [] call randomCargoLegalClass;
		_vehicle addItemCargo [_randomItem,1];
	};
};

_civilian1 = _grpCiv createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;

for "_i" from 1 to _passengerCount do {
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

_randomMusicProb = random 100;
if (_randomMusicProb > 90) then {
	_randomMusic = [] call randomMusicClass;
	_randomMusicTitle = _randomMusic select 0;
	_randomMusicLength = _randomMusic select 1;
	//systemchat format ['Music: %1', _randomMusicTitle];
	//systemchat format ['Music len: %1', _randomMusicLength];
	_vehicle say3D _randomMusicTitle;
	_vehicle say3D _randomMusicTitle;
	_vehicle say3D _randomMusicTitle;
	sleep _randomMusicLength;
};