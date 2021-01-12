**Simple trigger spawning squad of AI units and giving them a waypoint.**

Explanation of the code insde a trigger:

```
hint "trigger"; 
```

Shows player a hint saying "trigger" upon activation.
```
_alpha_1 = [getMarkerPos "spawn_location_0", WEST, ["B_Soldier_A_F", "B_Soldier_A_F", "B_Soldier_A_F", "B_Soldier_A_F"] call BIS_fnc_spawnGroup;
```
- _alpha1 - variable name of a created group
- getMarkerPos - gets position of a named marker
- WEST - side of a created group
- ["B_Soldier_A_F", [...]] - array of units in the group

```
 _waypoint_0 = _alpha_1 addWaypoint [getMarkerPos "waypoint_location_0", 0];
```
- _waypoint_0 - variable name of a created waypoint 
- _alpha_1 addWaypoint - adds waypoint to the group we created earlier
- getMarkerPos - gets position of a named marker
- 0 - sets random radius of 0 for the waypoint
```
_waypoint_0 setWaypointType "MOVE";
```
Sets type of waypoint we created to "MOVE"