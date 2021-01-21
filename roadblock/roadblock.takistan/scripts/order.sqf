_vehicle = _this select 0;
_order = _this select 1;
_vehicleSpawn = _vehicle getVariable "vehicleSpawn";
_vehicleDestinationFinal = _vehicle getVariable "vehicleDestinationFinal";
_vehicleGroup = _vehicle getVariable "vehicleGroup";
systemchat format ['Order group: %1', _vehicle];
systemchat format ['Order dest: %1', _order];

if (_order == "go") then {
	 _vehicleGroup addWaypoint [_vehicleDestinationFinal, 0];
	 } else {
		  _vehicleGroup addWaypoint [_vehicleSpawn, 0];
		  };