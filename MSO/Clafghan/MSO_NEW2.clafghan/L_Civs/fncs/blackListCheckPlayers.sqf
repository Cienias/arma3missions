/*  Checks if all players are in blacklisted areas
/*
/*  No Params
*/

private ["_unit","_notBlacklisted"];
_unit			= _this select 0;
_notBlacklisted = true;

{
	if ([_x, _unit] call BIS_fnc_inTrigger) exitWith {
		_notBlackListed = false;
	};
} forEach L_civs_blackList;
_notBlackListed;