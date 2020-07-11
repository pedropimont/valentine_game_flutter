import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/gestures.dart';

import '../../config.dart' as Config;
import '../../../paths.dart' as Path;
import 'controller.dart';

class PauseResumeButton extends PositionComponent with Tapable, Resizable {
  Controller controller;
  Sprite pauseSprite;
  Sprite startSprite;

  PauseResumeButton(this.controller) {
    pauseSprite = Sprite(Path.pauseButton);
    startSprite = Sprite(Path.resumeButton);
    anchor = Anchor.topRight;
  }

  @override
  void resize(Size size) {
    width = size.width * Config.pauseResumeButtonWidth;
    height = width / Config.pauseResumeDimensionRatio;
    x = size.width - 16;
    y = 20;
  }

  @override
  void render(Canvas c) {
    if (!controller.paused) pauseSprite.renderRect(c, toRect());
    if (controller.paused) startSprite.renderRect(c, toRect());
  }

  @override
  void onTapUp(TapUpDetails d) {
    controller.paused = !controller.paused;
  }
}
