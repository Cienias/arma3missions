_vehicle = _this select 0;
_order = _this select 1;
_vehicleSpawn = _vehicle getVariable "vehicleSpawn";
_vehicleDestinationFinal = _vehicle getVariable "vehicleDestinationFinal";
_vehicleGroup = _vehicle getVariable "vehicleGroup";

//systemchat format ['Order group: %1', _vehicle];
//systemchat format ['Order dest: %1', _order];

_vehicle addEventHandler ["GetOut",{
    if( ({alive _x} count (crew (_this select 0))) isEqualTo 0 )then{
        (_this select 0) removeAllEventHandlers "GetOut"; deleteVehicle (_this select 0);
    };
}];

_waypoint = objNull;

if (_order == "go") then {
	 _waypoint = _vehicleGroup addWaypoint [_vehicleDestinationFinal, 0];
	 } else {
		  _waypoint = _vehicleGroup addWaypoint [_vehicleSpawn, 0];
		  };


_waypoint setWaypointStatements ["true", "{doGetOut _x} forEach thisList; {deleteVehicle _x} forEach thisList; deleteVehicle this;"];
