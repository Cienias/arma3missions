_vehicle = _this select 0;
_junkyard = getMarkerPos "checkpoint_junkyard";
_dist = _vehicle distance _junkyard;

if (_dist > 10) then {
	systemchat format ['You can only remove vehicles close to the junkyard.'];
} else {
	deleteVehicle _vehicle;
};
