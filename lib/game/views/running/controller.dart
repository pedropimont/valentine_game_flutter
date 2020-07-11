import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../game.dart';
import '../../config.dart' as Config;
import '../../../utils.dart' as Utils;
import 'avatar.dart';
import 'bonus.dart';
import 'enemies.dart';
import 'healthPoints.dart';
import 'pauseResumeButton.dart';

class Controller extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  Avatar avatar;
  HealthPoints healthPoints;
  PauseResumeButton pauseResumeButton;

  bool paused = false;
  int lives = Config.lives;
  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  double enemyCurrentSpeed;

  int currentBonusSpawnTime;
  int currentEnemySpawnTime;

  int nextBonusSpawn;
  int nextEnemySpawn;

  Controller(this.game) : super() {
    // Better Place?
    size = game.size;
    laneWidth = size.width / laneQuantity;

    avatar = Avatar(this);
    healthPoints = HealthPoints(this);
    pauseResumeButton = PauseResumeButton(this);

    components..add(avatar)..add(pauseResumeButton)..add(healthPoints);

    currentBonusSpawnTime = Config.initialBonusSpawnTime;
    currentEnemySpawnTime = Config.enemyInitialSpawnTime;

    nextBonusSpawn = getNextBonusSpawn;
    nextEnemySpawn = getNextEnemySpawn;

    enemyCurrentSpeed = Config.enemyInitialSpeed;
  }

  int get getNextBonusSpawn =>
      nowTimestamp +
      (currentBonusSpawnTime *
              (1 +
                  Utils.nextDoubleFromMinusFactorToFactor(
                      Config.bonusRandomSpawnFactor)))
          .toInt();

  int get getNextEnemySpawn =>
      nowTimestamp +
      (currentEnemySpawnTime *
              (1 +
                  Utils.nextDoubleFromMinusFactorToFactor(
                      Config.enemyRandomSpawnFactor)))
          .toInt();

  int get nowTimestamp => DateTime.now().millisecondsSinceEpoch;

  @override
  void update(double t) {
    if (!paused) {
      if (nowTimestamp >= nextEnemySpawn) {
        _spawnRndEnemy();
        _updateEnemySpawnTime();
        _updateEnemyVelocity();
      }
      if (nowTimestamp >= nextBonusSpawn) {
        _spawnRndBonus();
        _updateBonusSpawnTime();
      }
      super.update(t);
    }
  }

  void loseHealthPoint() {
    lives -= 1;
    if (lives < 1) {
      // maybe should be like this, lose Health should just lose health not end game
      game.gameOver();
    }
  }

  void _spawnRndEnemy() {
    components.add(Enemy(this));
  }

  void _spawnRndBonus() {
    components.add(Bonus(this));
  }

  // This too will change for getters. Rename Variables also
  void _updateEnemySpawnTime() {
    if (currentEnemySpawnTime > Config.enemyMinSpawnTime)
      currentEnemySpawnTime -= Config.enemyChangeSpawnTime;
    nextEnemySpawn = getNextEnemySpawn;
  }

  void _updateBonusSpawnTime() {
    if (currentBonusSpawnTime > Config.minBonusSpawnTime)
      currentBonusSpawnTime -= Config.changeBonusSpawnTime;
    nextBonusSpawn = getNextBonusSpawn;
  }

  void _updateEnemyVelocity() {
    if (enemyCurrentSpeed < Config.enemyMaxSpeed)
      enemyCurrentSpeed += Config.enemyIncrementSpeed;
  }
}
