import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../utils.dart' as Utils;
import '../../../paths.dart' as Path;
import 'avatar.dart';
import 'controller.dart';

enum EnemyType { enemy1, enemy2, enemy3 }

class Enemy extends SpriteComponent with Resizable {
  Controller controller;
  Sprite sprite;
  int lane;
  double _fallVelocity;
  double _yToCheckForCollision;

  bool remove = false;

  Enemy._(this.sprite, this.controller) : super.fromSprite(16.0, 16.0, sprite);

  Enemy.enemy1(this.controller) {
    sprite = Sprite(Path.enemy1);
    Enemy._(sprite, controller);
  }

  Enemy.enemy2(this.controller) {
    sprite = Sprite(Path.enemy2);
    Enemy._(sprite, controller);
  }

  Enemy.enemy3(this.controller) {
    sprite = Sprite(Path.enemy3);
    Enemy._(sprite, controller);
  }

  factory Enemy(Controller controller) {
    int _rndInt = Utils.rnd.nextInt(EnemyType.values.length);
    EnemyType _rndEnemyType = EnemyType.values[_rndInt];
    switch (_rndEnemyType) {
      case EnemyType.enemy1:
        {
          return Enemy.enemy1(controller);
        }
      case EnemyType.enemy2:
        {
          return Enemy.enemy2(controller);
        }
      case EnemyType.enemy3:
        {
          return Enemy.enemy3(controller);
        }
      default:
        return Enemy.enemy1(controller);
    }
  }

  @override
  void resize(Size size) {
    anchor = Anchor.center;
    width = controller.laneWidth * Config.enemyWidth;
    height = width * Config.enemyDimensionRatio;
    lane = Utils.rnd.nextInt(controller.laneQuantity) + 1;
    x = lane * controller.laneWidth - controller.laneWidth / 2;
    y = 0;

    _fallVelocity = 10.0;
    _yToCheckForCollision = controller.size.height - controller.avatar.height;
  }

  @override
  void update(double t) {
    _fall(t);
    _rotate(t);
    if (_isHeightToCheckCollision) {
      if (_collision) {
        // controller.lostLife();
        remove = true;
      }
      remove = _hasReachedFloor;
    }
    super.update(t);
  }

  void _fall(double t) {
    y += t * _fallVelocity;
  }

  void _rotate(double t) {
    angle += 3.14 / 10 * t; // << ConfigFile: pi/10
  }

  bool get _hasReachedFloor =>
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
