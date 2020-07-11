import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:valentinegameflutter/game/views/running/enemies.dart';

import '../../game.dart';
import '../../config.dart' as Config;
import '../../../utils.dart' as Utils;
import 'avatar.dart';
import 'pauseResumeButton.dart';

class Controller extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  bool paused = false;
  Avatar avatar;
  PauseResumeButton pauseResumeButton;

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
    pauseResumeButton = PauseResumeButton(this);

    components..add(avatar)..add(pauseResumeButton);

//    currentBonusSpawnTime = Config.initialBonusSpawnTime;
    currentEnemySpawnTime = Config.enemyInitialSpawnTime;

//    nextBonusSpawn = getNextBonusSpawn;
    nextEnemySpawn = getNextEnemySpawn;

    enemyCurrentSpeed = Config.enemyInitialSpeed;
  }

//  int get getNextBonusSpawn =>
//      nowTimestamp +
//      (currentBonusSpawnTime *
//              (1 +
//                  Utils.nextDoubleFromMinusFactorToFactor(
//                      Config.bonusRandomSpawnFactor)))
//          .toInt();

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

      super.update(t);
    }
  }

  void _spawnRndEnemy() {
    components.add(Enemy(this));
  }

  // This too will change for getters. Rename Variables also
  void _updateEnemySpawnTime() {
    if (currentEnemySpawnTime > Config.enemyMinSpawnTime)
      currentEnemySpawnTime -= Config.enemyChangeSpawnTime;
    nextEnemySpawn = getNextEnemySpawn;
  }

  void _updateEnemyVelocity() {
    if (enemyCurrentSpeed < Config.enemyMaxSpeed)
      enemyCurrentSpeed += Config.enemyIncrementSpeed;
  }
}
