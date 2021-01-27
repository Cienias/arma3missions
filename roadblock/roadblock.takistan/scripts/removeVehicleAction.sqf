_vehicle = _this select 0;
_player = player;

_isEngineer = _player getVariable ['ace_isEngineer', 0];


if (_isEngineer > 0) then {
	_aceInteractionDelete = ["Interactions", "Remove vehicle", "", {[_target, "go"]execVM "scripts\removeVehicle.sqf";}, {true}] call ace_interact_menu_fnc_createAction;
	[_vehicle, 0, ["ACE_MainActions"], _aceInteractionDelete] call ace_interact_menu_fnc_addActionToObject;
} else {
};


