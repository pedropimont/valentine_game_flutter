import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../../paths.dart' as Path;
import '../../config.dart' as Config;

import 'controller.dart';

class HealthPoints extends PositionComponent {
  Controller controller;
  Sprite sprite = Sprite(Path.healthPoint);

  HealthPoints(this.controller);

  @override
  void resize(Size size) {
    x = 16;
    y = 16;
    width = size.width * Config.healthPointWidth;
    height = width / Config.healthPointDimensionRatio;
    super.resize(size);
  }

  @override
  void render(Canvas c) {
    if (controller.lives > 0) {
      for (int i = 0; i <= controller.lives - 1; i++) {
        sprite.renderRect(c, toRect().translate(i * (width + 8), 0));
      }
    }
  }
}
