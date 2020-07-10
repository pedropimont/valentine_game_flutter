import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:valentinegameflutter/game/game.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import 'controller.dart';

enum AvatarStatus { flipping, moving, idle } // moving not doing anything

class Avatar extends SpriteComponent {
  Controller controller;
  int lane;
  AvatarStatus status = AvatarStatus.idle;

  Avatar(this.controller) : super.fromSprite(16.0, 16.0, Sprite(Path.avatar)) {
    anchor = Anchor.center;
    lane = (controller.laneQuantity + 1) ~/ 2;
  }

  @override
  void update(double t) {
    if (status == AvatarStatus.flipping) _flip();
    super.update(t);
  }

  @override
  void resize(Size size) {
    width = controller.laneWidth * Config.avatarWidth;
    height = width * Config.avatarDimensionRatio;
    x = lane * controller.laneWidth - controller.laneWidth / 2;
    y = size.height - height / 2;
  }

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
    // .add(Bullet());
  }

  void handleHorizontalDragEnd(DragDirection dragDirection) {
    switch (dragDirection) {
      case DragDirection.right:
        {
          if (lane < 5) {
            renderFlipX = false;
            lane += 1;
          }
          break;
        }
      case DragDirection.left:
        {
          if (lane > 1) {
            renderFlipX = true;
            lane -= 1;
          }
          break;
        }
    }
    // duplicate
    x = lane * controller.laneWidth - controller.laneWidth / 2;
  }
}
