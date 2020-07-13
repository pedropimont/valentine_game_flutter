import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:valentinegameflutter/game/views/gameOver/gameOverView.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;
import 'gameOverView.dart';

class BrokenHeart extends SpriteComponent {
  GameOverView controller;

  BrokenHeart(this.controller)
      : super.fromSprite(16.0, 16.0, Sprite(Path.brokenHeart)) {
    anchor = Anchor.center;
  }

  @override
  void resize(Size size) {
    width = size.width * Config.brokenHeartInitialWidth;
    height = width / Config.brokenHeartDimensionRatio;
    x = size.width / 2;
    y = size.height * Config.brokenHeartY;
    super.resize(size);
  }

  @override
  void update(double t) {
    if (controller.animating) {
      angle += t * Config.brokenHeartSpinVelocity;
      width += Config.brokenHeartGrownFactor;
      height = width / Config.brokenHeartDimensionRatio;
      if (angle >= Config.brokenHeartSpins) {
        angle = 0;
        controller.animating = false;
      }
    }
    super.update(t);
  }
}
