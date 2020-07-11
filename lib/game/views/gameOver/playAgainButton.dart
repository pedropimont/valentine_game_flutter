import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;
import 'gameOverView.dart';

class PlayAgainButton extends SpriteComponent with Tapable, Resizable {
  GameOverView gameOverView;

  PlayAgainButton(this.gameOverView)
      : super.fromSprite(16.0, 16.0, Sprite(Path.playAgainButton)) {
    anchor = Anchor.topCenter;
  }

  @override
  void resize(Size size) {
    width = size.width * Config.playAgainButtonWidth;
    height = width / Config.playAgainButtonDimensionRatio;
    y = size.height * Config.playAgainButtonY;
    x = size.width / 2;
  }

  @override
  void render(Canvas canvas) {
    if (!gameOverView.animating) super.render(canvas);
  }

  @override
  void onTapUp(TapUpDetails details) {
    gameOverView.restart();
    super.onTapUp(details);
  }
}
