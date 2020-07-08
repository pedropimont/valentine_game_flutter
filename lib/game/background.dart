import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../paths.dart' as Paths;

class Background extends SpriteComponent {
  Background() : super.fromSprite(16.0, 16.0, Sprite(Paths.background));

  @override
  void resize(Size size) {
    height = size.height;
    width = size.width;
  }
}
