import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import 'controller.dart';
import 'bonus.dart';

class Bullet extends SpriteComponent with Resizable {
  Controller controller;
  bool remove = false;

  Bullet(this.controller) : super.fromSprite(16.0, 16.0, Sprite(Path.bullet));

  void checkForCollision() {
    for (Bonus bonus in controller.components.whereType<Bonus>()) {
      if (this.toRect().contains(bonus.toRect().topLeft) ||
          this.toRect().contains(bonus.toRect().topCenter) ||
          this.toRect().contains(bonus.toRect().topRight)) {
        this.remove = true;
      }
    }
  }

  @override
  void update(double t) {
    // speed should use gameSpeed?
    checkForCollision();
    y -= t * Config.bulletSpeed;
    if (y <= 0) remove = true;
    super.update(t);
  }

  @override
  void resize(Size size) {
    // GameConfig for this?
    x = controller.avatar.renderFlipX
        ? controller.avatar.x - controller.avatar.width * 2 / 5
        : controller.avatar.x;

    // GameConfig.avatarMouthY?
    y = size.height - 2 / 3 * controller.avatar.height;

    width = controller.laneWidth * Config.bulletWidth;
    height = width / Config.bulletDimensionRatio;
  }

  @override
  void onDestroy() {}

  @override
  bool destroy() {
    return remove;
  }
}
