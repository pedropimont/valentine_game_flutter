import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../utils.dart' as Utils;
import '../../../paths.dart' as Path;

import 'controller.dart';

enum EnemyType { enemy1, enemy2, enemy3 }

class Enemy extends SpriteComponent with Resizable {
  Controller controller;
  Sprite sprite;
  int lane;
  double _fallVelocity;
  double _yToCheckForCollision;

  bool remove = false;

  factory Enemy(Controller controller) {
    int _rndInt = Utils.rnd.nextInt(EnemyType.values.length);
    EnemyType _rndEnemyType = EnemyType.values[_rndInt];
    switch (_rndEnemyType) {
      case EnemyType.enemy1:
        {
          return Enemy._(Sprite(Path.enemy1), controller);
        }
      case EnemyType.enemy2:
        {
          return Enemy._(Sprite(Path.enemy2), controller);
        }
      case EnemyType.enemy3:
        {
          return Enemy._(Sprite(Path.enemy3), controller);
        }
      default:
        return Enemy._(Sprite(Path.enemy1), controller);
    }
  }

  Enemy._(this.sprite, this.controller) : super.fromSprite(16.0, 16.0, sprite) {
    lane = Utils.rnd.nextInt(controller.laneQuantity) + 1;
    _fallVelocity = controller.enemyCurrentSpeed *
        (1 +
            Utils.nextDoubleFromMinusFactorToFactor(
                Config.enemyRandomSpeedFactor));
    _yToCheckForCollision = controller.size.height - controller.avatar.height;

    anchor = Anchor.center;
    width = controller.laneWidth * Config.enemyWidth;
    height = width * Config.enemyDimensionRatio;
    x = lane * controller.laneWidth - controller.laneWidth / 2;
    y = 0;
  }

  @override
  void resize(Size size) {
    // TODO: It's not being called when creating new enemy. Why?
  }

  @override
  void update(double t) {
    _fall(t);
    _rotate(t);
    if (_isHeightToCheckCollision) {
      if (_collision) {
        controller.loseHealthPoint();
        remove = true;
      }
      remove = _isOffScreen;
    }
    super.update(t);
  }

  void _fall(double t) {
    y += t * _fallVelocity;
  }

  void _rotate(double t) {
    angle += Config.enemyRotateVelocity * t;
  }

  /// The Height used to decide if enemy is removed is relative to the Avatar's height
  // TODO: poor variable naming -> should make reference to avatar height proportion
  bool get _isOffScreen =>
      (y >= _yToCheckForCollision * Config.enemyHeightToRemove);

  /// no point in keep checking for collisions until certain y position
  bool get _isHeightToCheckCollision => (y >= _yToCheckForCollision);

  bool get _collision {
    if (this.toRect().contains(controller.avatar.toRect().topLeft) ||
        this.toRect().contains(controller.avatar.toRect().topCenter) ||
        this.toRect().contains(controller.avatar.toRect().topRight)) {
      return true;
    }
    return false;
  }

  @override
  bool destroy() {
    return remove;
  }
}
