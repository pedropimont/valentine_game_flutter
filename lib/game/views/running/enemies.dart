import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../utils.dart' as Utils;
import '../../../paths.dart' as Path;
import 'controller.dart';

enum EnemyType { covid }

class Enemy extends SpriteComponent with Resizable {
  Controller controller;
  Sprite sprite;
  int lane;
  bool remove = false;
  double speed;

  factory Enemy(Controller controller) {
    int _rndEnemyType = Utils.rnd.nextInt(EnemyType.values.length);
    switch (_rndEnemyType) {
      case 0:
        {
          return Enemy.covid(controller);
        }
      default:
        return Enemy.covid(controller);
    }
  }

  Enemy.covid(this.controller) {
    sprite = Sprite(Path.covid);
    Enemy._(sprite, controller);
  }

  Enemy._(this.sprite, this.controller) : super.fromSprite(16.0, 16.0, sprite);

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
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
