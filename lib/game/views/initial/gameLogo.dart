import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

import '../../../paths.dart' as Path;
import '../../config.dart' as Config;

class GameLogo extends SpriteComponent with Resizable {
  GameLogo() : super.fromSprite(16.0, 16.0, Sprite(Path.gameLogo));

  @override
  void resize(Size size) {
    anchor = Anchor.topCenter;
    x = size.width / 2;
    y = size.height * Config.gameNameY;
    width = size.width * Config.gameNameWidthPortion;
    height = width / Config.gameNameDimensionRatio;
  }
}
