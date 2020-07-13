import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import 'gameOverView.dart';

class BrokenHeart extends SpriteComponent {
  GameOverView gameOverView;

  BrokenHeart(this.gameOverView)
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
    if (gameOverView.animating) {
      _spin(t);
      _grown(t);
      if (angle >= Config.brokenHeartSpins) {
        angle = 0;
        gameOverView.animating = false;
      }
    }
    super.update(t);
  }

  void _spin(double t) {
    angle += t * Config.brokenHeartSpinVelocity;
  }

  void _grown(double t) {
    width += t * Config.brokenHeartGrownFactor;
    height = width / Config.brokenHeartDimensionRatio;
  }
}
