randomCivilianClass = compile preprocessFile "scripts\configs\randomCivilian.sqf";
randomVehicleClass = compile preprocessFile "scripts\configs\randomVehicle.sqf";

_civilianRandomClass = [] call randomCivilianClass;
_vehicleRandomClass = [] call randomVehicleClass;

_posSpawnString = selectRandom ["spawn_south_0", "spawn_north_0", "spawn_north_1", "spawn_south_1"];
_posSpawn = getMarkerPos _posSpawnString;

_posDestCheckpoint = _posSpawn;
_posDestFinal = _posSpawn;

if (_posSpawnString == "spawn_south_0" || _posSpawnString == "spawn_south_1") then {
	 _posDestCheckpoint = getMarkerPos "checkpoint_stop_south_0";
	 _posDestFinal = getMarkerPos selectRandom ["spawn_north_0", "spawn_north_1"];
	 } else {
			_posDestCheckpoint = getMarkerPos "checkpoint_stop_north_0";
			_posDestFinal = getMarkerPos selectRandom ["spawn_south_0", "spawn_south_1"];
		  };

_grpBomber = createGroup [civilian, true];
_grpBomber deleteGroupWhenEmpty true;


_vehicle = _vehicleRandomClass createVehicle _posSpawn;
_grpBomber addVehicle _vehicle;

_civilian1 = _grpBomber createUnit [_civilianRandomClass, _posSpawn, [], 0, "NONE"];
_civilian1 moveInDriver _vehicle;
_grpBomber selectLeader _civilian1;

_waypoint = _grpBomber addWaypoint [getMarkerPos "checkpoint_center", 0];

_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointSpeed "FULL";
//_waypoint setWaypointStatements ["true", "_bomb = 'Bo_GBU12_LGB' createVehicle position this; _bomb setdamage 1;"];

//[[_vehicle],'scripts\playBeepMulti.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];

_vehicle setVariable ["vehicleDisarmed", false, true];

[[_vehicle],'scripts\bomberCar.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];

[[_vehicle],'scripts\removeVehicleAction.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];
[[_vehicle],'scripts\disarmVehicleAction.sqf'] remoteExec ['BIS_fnc_execVM', 0, true];