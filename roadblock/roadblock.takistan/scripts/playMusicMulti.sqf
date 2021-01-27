_vehicle = _this select 0;
_randomMusicTitle = _this select 1;
_randomMusicLength = _this select 2;

while {true} do {
_vehicle say3D _randomMusicTitle;
sleep _randomMusicLength;
};
