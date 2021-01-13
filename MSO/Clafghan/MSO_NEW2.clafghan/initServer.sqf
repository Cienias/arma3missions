#include "L_Civs\functions.sqf";
#include "L_Civs\classes.sqf";
#include "L_Civs\blacklist.sqf";
_towing = execVM "fn_advancedTowingInit.sqf";
_slingload = execVM "fn_advancedSlingLoadingInit.sqf";
_muezzin = execVM "muezzin.sqf";
[10, 1500, 2400] spawn L_fnc_civs_spawnCivs;
setTerrainGrid 25;
