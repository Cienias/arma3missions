_vehicle = _this select 0;


_aceInteractionGo = ["Interactions", "You can go", "", {[_target, "go"]execVM "scripts\order.sqf";}, {true}] call ace_interact_menu_fnc_createAction;
_aceInteractionTurnAround = ["Interactions", "Turn around", "", {[_target, "turnAround"]execVM "scripts\order.sqf";}, {true}] call ace_interact_menu_fnc_createAction; 

[_vehicle, 0, ["ACE_MainActions"], _aceInteractionGo] call ace_interact_menu_fnc_addActionToObject;
[_vehicle, 0, ["ACE_MainActions"], _aceInteractionTurnAround] call ace_interact_menu_fnc_addActionToObject;