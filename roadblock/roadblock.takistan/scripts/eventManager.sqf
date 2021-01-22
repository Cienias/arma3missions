randomEventClass = compile preprocessFile "scripts\configs\randomEvent.sqf";

while {true} do {
	_randomEventClass = [] call randomEventClass;
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