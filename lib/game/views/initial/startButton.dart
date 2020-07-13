import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import '../../../paths.dart' as Path;
import '../../config.dart' as Config;

import '../../game.dart';

class StartButton extends SpriteComponent with Resizable, Tapable {
  ValentineGame game;

  StartButton(this.game)
      : super.fromSprite(16.0, 16.0, Sprite(Path.startButton));

  @override
  void resize(Size size) {
    anchor = Anchor.topCenter;
    x = size.width / 2;
    y = size.height * Config.startButtonY;
    width = size.width * Config.startButtonWidthPortion;
    height = width / Config.startButtonDimensionRatio;
  }

  @override
  void onTapUp(TapUpDetails details) {
    game.start();
  }
}
