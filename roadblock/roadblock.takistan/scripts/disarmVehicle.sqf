_vehicle = _this select 0;

_vehicle setVariable ["vehicleDisarmed", true, true];

[_vehicle,0,["ACE_MainActions","Disarm vehicle"]] call ace_interact_menu_fnc_removeActionFromObject;