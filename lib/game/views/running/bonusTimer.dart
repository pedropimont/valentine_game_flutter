import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import '../../../paths.dart' as Path;
import '../../../utils.dart' as Utils;
import '../../config.dart' as Config;
import 'controller.dart';
import 'bonus.dart';

// TODO: GameConfig

class BonusTimer extends SpriteComponent {
  Controller controller;
  Bonus bonus;
  bool remove = false;
  double xOffset;
  double yOffset;

  TextPainter timerText;
  Offset textOffset;

  double totalTime;

  BonusTimer(this.controller, this.bonus)
      : super.fromSprite(16.0, 16.0, Sprite(Path.bonusTimer)) {
    totalTime = Utils.getRandomInt(
            Config.bonusMinTimerDuration, Config.bonusMaxTimerDuration)
        .toDouble();

    xOffset = controller.laneWidth * .25;
    yOffset = controller.laneWidth * .25;

    timerText = TextPainter(
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void resize(Size size) {
    width = controller.laneWidth * .30;
    height = controller.laneWidth * .30;
  }

  @override
  void render(Canvas c) {
    super.render(c);
    timerText.paint(c, textOffset);
  }

  @override
  void update(double t) {
    x = bonus.x - xOffset;
    y = bonus.y - yOffset;

    totalTime -= t;

    if (totalTime < 0) {
      bonus.remove = true;
      remove = true;
    }
    timerText.text = TextSpan(
      text: totalTime.toInt().toString(),
      style: TextStyle(
        letterSpacing: -2,
        color: Color(0xff000000),
        fontSize: controller.laneWidth * .18,
      ),
    );
    timerText.layout();

    textOffset = Offset(controller.laneWidth / 15, timerText.height / 10);

    super.update(t);
  }

  @override
  void onDestroy() {
    // TODO: não ta chamando essa joça antes de exclui do thread
  }

  @override
  bool destroy() {
    return remove;
  }
}
