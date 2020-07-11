import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import 'gameOverView.dart';

class SadAvatar extends SpriteComponent {
  GameOverView gameOverView;

  SadAvatar(this.gameOverView)
      : super.fromSprite(16.0, 16.0, Sprite(Path.sadAvatar)) {
    anchor = Anchor.center;
  }

  @override
  void resize(Size size) {
    width = size.width * Config.avatarSadWidth;
    height = width / Config.avatarSadDimensionRatio;
    x = size.width * Config.avatarSadX;
    y = size.height * Config.avatarSadY;
    angle = Config.avatarSadAngle;
  }

  @override
  void render(Canvas canvas) {
    if (!gameOverView.animating) super.render(canvas);
  }
}
