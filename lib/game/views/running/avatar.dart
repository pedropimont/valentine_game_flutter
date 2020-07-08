import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;
import '../../game.dart';

enum AvatarStatus { flipping, moving, idle }

class Avatar extends SpriteComponent {
  int flipInverter = 1; // Inverts the flip direction when moved while flipping
  int lane;
  AvatarStatus status = AvatarStatus.idle;

  Avatar() : super.fromSprite(16.0, 16.0, Sprite(Path.avatar)) {
    anchor = Anchor.center;
//    lane = (lanes + 1) ~/ 2;
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

  // TODO: possible to remove flipInverter?
  void _flip() {
    if (angle.abs() >= 2 * pi) {
      angle = 0.0;
      status = AvatarStatus.idle;
    } else {
      angle += renderFlipX ? pi / 15 * flipInverter : -pi / 15 * flipInverter;
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

  void handleHorizontalDragEnd() {
    // TODO: Implement FlipInverter and HorizontalDrag
  }
}
