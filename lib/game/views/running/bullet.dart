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

  @override
  void resize(Size size) {
    /// Since avatar is not symmetrical, Bullet's X will change when avatar is mirrored
    x = controller.avatar.renderFlipX
        ? controller.avatar.x - controller.avatar.width * 2 / 5
        : controller.avatar.x;

    /// Height where bullet will be shoot by the avatar's gun
    y = size.height - 2 / 3 * controller.avatar.height;

    width = controller.laneWidth * Config.bulletWidth;
    height = width / Config.bulletDimensionRatio;
  }

  @override
  void update(double t) {
    y -= t * Config.bulletSpeed;
    if (_collision) remove = true;
    if (_isOffScreen) remove = true;
    super.update(t);
  }

  bool get _collision {
    for (Bonus bonus in controller.components.whereType<Bonus>()) {
      if (this.toRect().contains(bonus.toRect().topLeft) ||
          this.toRect().contains(bonus.toRect().topCenter) ||
          this.toRect().contains(bonus.toRect().topRight)) {
        return true;
      }
    }
    return false;
  }

  bool get _isOffScreen => y <= 0;

  @override
  bool destroy() {
    return remove;
  }
}
