import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import '../../../utils.dart' as Utils;
import '../../../paths.dart' as Path;

import 'controller.dart';
import 'bonusTimer.dart';

// TODO: GameConfig

enum BonusType { bonus1, bonus2, bonus3 }

class Bonus extends AnimationComponent with Resizable {
  Controller controller;
  List<Sprite> sprites;
  Offset targetOffset;
  bool remove = false;
  bool angleFlip = false;
  double xOffset;
  double yOffset;

  double get speed => controller.laneWidth * 3;

  factory Bonus(Controller controller) {
    int _rndInt = Utils.rnd.nextInt(BonusType.values.length);
    BonusType _rndEnemyType = BonusType.values[_rndInt];
    List<Sprite> _spriteList;
    switch (_rndEnemyType) {
      case BonusType.bonus1:
        {
          _spriteList =
              Path.bonus1SpritePathList.map((path) => Sprite(path)).toList();
          return Bonus._(_spriteList, controller);
        }
      case BonusType.bonus2:
        {
          _spriteList =
              Path.bonus2SpritePathList.map((path) => Sprite(path)).toList();
          return Bonus._(_spriteList, controller);
        }
      case BonusType.bonus3:
        {
          _spriteList =
              Path.bonus3SpritePathList.map((path) => Sprite(path)).toList();
          return Bonus._(_spriteList, controller);
        }
      default:
        _spriteList =
            Path.bonus1SpritePathList.map((path) => Sprite(path)).toList();
        return Bonus._(_spriteList, controller);
    }
  }

  Bonus._(this.sprites, this.controller)
      : super(16.0, 16.0, Animation.spriteList(sprites, stepTime: 0.5)) {
    anchor = Anchor.topCenter;

    controller.add(BonusTimer(controller, this));

    setTargetOffset();
  }

  @override
  void resize(Size size) {
    x = Utils.getRandomInt(0, size.width.toInt()).toDouble();
    y = Utils.getRandomInt(0, size.height ~/ 2.25).toDouble();
    width = controller.laneWidth / 2;
    height = width;
  }

  void setTargetOffset() {
    xOffset = Utils.rnd.nextDouble() *
        (controller.game.size.width - (controller.laneWidth));
    yOffset = (Utils.rnd.nextDouble() *
            (controller.game.size.height / 2 - (controller.laneWidth))) +
        (controller.laneWidth);
    targetOffset = Offset(xOffset, yOffset);
  }

  @override
  void update(double t) {
    // TODO: random velocity every time change target direction
    double stepDistance = 15 * t;

    if (!angleFlip) angle += pi / 2 * t;
    if (angleFlip) angle -= pi / 2 * t;
    // TODO: problem when skip frame?
    if (angle.abs() >= pi / 4) angleFlip = !angleFlip;

    Offset toTarget = targetOffset - Offset(x, y);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      x += stepToTarget.dx;
      y += stepToTarget.dy;
    } else {
      setTargetOffset();
    }
    super.update(t);
  }

  @override
  bool destroy() {
    return remove;
  }

  @override
  void onDestroy() {}
}
