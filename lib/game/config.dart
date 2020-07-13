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

//    Health Points
const double healthPointWidth = 1 / 12; // from screen
const double healthPointDimensionRatio = 1; // <<<<<<<< check

// Running
const int laneQuantity = 5;
const int lives = 3;
//    Avatar
const double avatarWidth = 1; // 100% laneWidth
const double avatarDimensionRatio = 1; // <<<<<<<<<<<<<<< check
const double avatarFlipVelocity = pi / 15; // (pi / 15 * 60)/s
//    PauseResumeButton
const double pauseResumeButtonWidth = 2 / 7; // 25% screen
const double pauseResumeDimensionRatio = 168 / 46; // w x h (Standard)
//    Bullet
const double bulletWidth = 0.4;
const double bulletDimensionRatio = 1;
const double bulletSpeed = 500; // 10 * t
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

//    Bonus
const int bonusMinTimerTime = 10;
const int bonusMaxTimerTime = 25;
const double bonusSpeed = 10;
const double bonusRandomSpeedFactor = 1;
const double bonusWidth = 0.35; // 35% from laneWidth
const double bonusDimensionRatio = 1;
//      Bonus Spawn Controller
const double bonusRandomSpawnFactor = 0.25; // +25% or -25%
const int initialBonusSpawnTime = 50000; // 50.000ms = 50s
const int minBonusSpawnTime = 10000;
const int changeBonusSpawnTime = 500;
const int bonusMaxTimerDuration = 30; // seconds
const int bonusMinTimerDuration = 7;

// Game Over View
//    Game Over : Anchor.center
const double brokenHeartInitialWidth = 1 / 10;
const double brokenHeartDimensionRatio = 286 / 337; // w x h (Standard)
const double brokenHeartY = 2 / 5;
const double brokenHeartGrownFactor = 2.7;
const double brokenHeartSpins = pi * 8; // 4 Spins
const double brokenHeartSpinVelocity = pi * 10; // pi * 10 * t

//    Play Again Button : Anchor.topCenter
const double playAgainButtonWidth = 2 / 3;
const double playAgainButtonDimensionRatio = 470 / 98; // w x h
const double playAgainButtonY = 3 / 4;

//    Sad Avatar : Anchor.center
const double avatarSadWidth = 2 / 3;
const double avatarSadDimensionRatio = 498 / 558; // w x h (Standard)
const double avatarSadAngle = pi * 1 / 2;
const double avatarSadY = 3 / 4;
const double avatarSadX = 3 / 4;
