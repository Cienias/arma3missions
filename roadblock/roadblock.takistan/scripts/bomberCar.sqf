_vehicle = _this select 0;
_armed = false;
_detonationTimer = random [15, 30, 60];
while {alive _vehicle} do {
	_disarmedByPlayer = _vehicle getVariable "vehicleDisarmed";
	if (_vehicle inArea "checkpoint_vincinity") then { 
		_armed = true;
	} else {
		_armed = false;
	};
	if (_armed && !_disarmedByPlayer) then {
		//systemchat format ['Bomb timer: %1', _detonationTimer];
		_vehicle say3D "beep";
		_detonationTimer = _detonationTimer - 1;
	} else {

	};
	if (_detonationTimer < 0) then {
		_bomb = 'Bo_GBU12_LGB' createVehicle position _vehicle; 
		_bomb setdamage 1;
	} else {

	};
	sleep 1;
};