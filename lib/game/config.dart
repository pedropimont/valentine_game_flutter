library configs;

import 'dart:math' show pi;

// Initial View
//    GameName -> Anchor: Top Center
const double gameNameWidthPortion = 3 / 4; // 75% of screen width
const double gameNameDimensionRatio = 438 / 195; // w x h (Standard)
const double gameNameY = 1 / 4; // 25% Screen Height from Top

//    Start Button -> Anchor: Top Center
const double startButtonWidthPortion = 2 / 3;
const double startButtonDimensionRatio = 628 / 87;
const double startButtonY = 3 / 4;

// Running
const int laneQuantity = 5;
//    Avatar
const double avatarWidth = 1; // 100% laneWidth
const double avatarDimensionRatio = 1; // <<<<<<<<<<<<<<< check
const double avatarFlipVelocity = pi / 15; // (pi / 15 * 60)/s
//    PauseResumeButton
const double pauseResumeButtonWidth = 2 / 7; // 25% screen
const double pauseResumeDimensionRatio = 168 / 46; // w x h (Standard)

//    Enemies
const double enemyWidth = 0.70; // 35% from laneWidth
const double enemyDimensionRatio = 1;
const double enemyHeightToRemove = 0.75; // 75% Avatar
const double enemyInitialSpeed = 320;
const double enemyMaxSpeed = 800;
const double enemyIncrementSpeed = 0.20;
const double enemyRandomSpeedFactor = 0.25;
//      Enemies Spawn Controllers
const double enemyRandomSpawnFactor = 0.25;
const int enemyInitialSpawnTime = 1600;
const int enemyMinSpawnTime = 700;
const int enemyChangeSpawnTime = 1;
