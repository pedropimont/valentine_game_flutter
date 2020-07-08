import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;

import 'controller.dart';
import 'runningView.dart';

enum AvatarStatus { flipping, moving, idle }

class Avatar extends SpriteComponent {
  RunningView runningView;
  int lane;
  AvatarStatus status = AvatarStatus.idle;

  Avatar(this.runningView) : super.fromSprite(16.0, 16.0, Sprite(Path.avatar)) {
    anchor = Anchor.center;
    lane = (runningView.laneQuantity + 1) ~/ 2;
  }

  @override
  void update(double t) {
    if (status == AvatarStatus.flipping) _flip();
    super.update(t);
  }

  @override
  void resize(Size size) {
    width = runningView.laneWidth * Config.avatarWidth;
    height = width * Config.avatarDimensionRatio;
    x = lane * runningView.laneWidth - runningView.laneWidth / 2;
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

  void handleHorizontalDragEnd() {
    // TODO: Implement FlipInverter and HorizontalDrag
  }
}
