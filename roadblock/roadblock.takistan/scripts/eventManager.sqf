randomEventLightClass = compile preprocessFile "scripts\configs\randomEventLight.sqf";
randomEventMediumClass = compile preprocessFile "scripts\configs\randomEventMedium.sqf";
randomEventHeavyClass = compile preprocessFile "scripts\configs\randomEventHeavy.sqf";
randomEventSpecialClass = compile preprocessFile "scripts\configs\randomEventSpecial.sqf";

_oppositionHeavy = objNull;
_oppositionMedium = objNull;

switch (paramsArray select 3) do {
	case 1: { _oppositionHeavy = 98; _oppositionMedium = 89;};
	case 2: { _oppositionHeavy = 94; _oppositionMedium = 74;};
	case 3: { _oppositionHeavy = 74; _oppositionMedium = 49;};
	default { _oppositionHeavy = 89; _oppositionMedium = 74;};
};

_eventSpecial = _oppositionMedium - 10;

while {true} do {
	//_randomEventClass = [] call randomEventClass;

	_eventRandom = random 100;
	_randomEventClass = objNull;
	if (_eventRandom > _oppositionHeavy) then {
		_randomEventClass = [] call randomEventHeavyClass;
	} else {
		if (_eventRandom > _oppositionMedium) then {
			_randomEventClass = [] call randomEventMediumClass;
		} else {
			if (_eventRandom > _eventSpecial) then {
				_randomEventClass = [] call randomEventSpecialClass;
			} else {
				_randomEventClass = [] call randomEventLightClass;
			};
		};
	};

	_intervalLow = random [180, 300, 600];
	_intervalMedium = random [90, 180, 300];
	_intervalHigh = random [30, 120, 180];
	_intervalDEBUG = random [5, 10, 15];
	_intervalRandom = selectRandom [_intervalLow, _intervalMedium, _intervalHigh];

	switch (paramsArray select 2) do {
		case 1: { sleep _intervalLow};
		case 2: { sleep _intervalMedium};
		case 3: { sleep _intervalHigh};
		case 4: { sleep _intervalRandom};
		case 5: { sleep _intervalDEBUG};
		default { sleep _intervalMedium};
	};

	_handle = execVm _randomEventClass;
};