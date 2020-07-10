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
  }

  @override
  void update(double t) {
    // _fall();
    // _rotate();
    // _checkForCollision;
    // if (y >= xx) remove = true
    super.update(t);
  }
}
