import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import '../../game.dart';
import 'bullet.dart';
import 'controller.dart';

enum AvatarStatus { flipping, moving, idle } // moving not doing anything

class Avatar extends SpriteComponent {
  Controller controller;
  int lane;
  AvatarStatus status = AvatarStatus.idle;

  Avatar(this.controller) : super.fromSprite(16.0, 16.0, Sprite(Path.avatar));

  @override
  void update(double t) {
    if (status == AvatarStatus.flipping) _flip();
    super.update(t);
  }

  @override
  void resize(Size size) {
    anchor = Anchor.center;
    lane = (controller.laneQuantity + 1) ~/ 2;
    width = controller.laneWidth * Config.avatarWidth;
    height = width * Config.avatarDimensionRatio;
    x = _getX;
    y = size.height - height / 2;
  }

  double get _getX => lane * controller.laneWidth - controller.laneWidth / 2;

  void _flip() {
    angle += renderFlipX ? pi / 15 : -pi / 15;
    if (angle.abs() >= 2 * pi) {
      status = AvatarStatus.idle;
      angle = 0.0;
    }
  }

  void handleTapUp() {
    if (status != AvatarStatus.flipping) {
      status = AvatarStatus.flipping;
      _shoot();
    }
  }

  void _shoot() {
    controller.add(Bullet(controller));
  }

  void handleHorizontalDragEnd(DragDirection dragDirection) {
    if (dragDirection == DragDirection.right) {
      if (lane < Config.laneQuantity) {
        renderFlipX = false;
        lane += 1;
      }
    }
    if (dragDirection == DragDirection.left) {
      if (lane > 1) {
        renderFlipX = true;
        lane -= 1;
      }
    }
    x = _getX;
  }
}
