**Prosty wyzwalacz tworzący oddział AI i ustawiający im waypoint.**
[English Readme](https://github.com/Cienias/arma3missions/blob/main/tutorials/spawn_squad_on_trigger.VR/README.md)

Wyjaśnienie kodu wewnątrz wyzwalacza:

```
hint "trigger"; 
```

Wyświetla hint o treści "trigger" po wejściu w wyzwalacz;
```
_alpha_1 = [getMarkerPos "spawn_location_0", WEST, ["B_Soldier_A_F", "B_Soldier_A_F", "B_Soldier_A_F", "B_Soldier_A_F"] call BIS_fnc_spawnGroup;
```
- _alpha1 - nazwa zmiennej dla utworzonej grupy
- getMarkerPos - wybiera pozycję markera na którym pojawi się utworzony oddział
- WEST - przynależność utworzonej grupy
- ["B_Soldier_A_F", [...]] - lista jednostek należących do tworzonej grupy

```
 _waypoint_0 = _alpha_1 addWaypoint [getMarkerPos "waypoint_location_0", 0];
```
- _waypoint_0 - nazwa zmiennej dla utworzonego waypointa
- _alpha_1 addWaypoint - dodaje utworzony waypoint grupie _alpha1 utworzonej wcześniej
- getMarkerPos - wybiera pozycję markera na którym pojawi się utworzony waypoint
- 0 - ustawia losową pozycję waypointa w odległości 0 metrów od markera
```
_waypoint_0 setWaypointType "MOVE";
```
Ustawia typ waypointa na "MOVE"