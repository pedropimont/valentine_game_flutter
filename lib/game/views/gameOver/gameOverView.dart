import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../game.dart';
import 'brokenHeart.dart';
import 'playAgainButton.dart';
import 'sadAvatar.dart';

class GameOverView extends PositionComponent
    with HasGameRef, Tapable, ComposedComponent {
  BrokenHeart brokenHeart;
  PlayAgainButton playAgainButton;
  SadAvatar sadAvatar;

  bool animating = true;
  bool remove = false;
  ValentineGame game;

  GameOverView(this.game) {
    brokenHeart = BrokenHeart(this);
    playAgainButton = PlayAgainButton(this);
    sadAvatar = SadAvatar(this);

    components..add(brokenHeart)..add(sadAvatar)..add(playAgainButton);
  }

  void restart() {
    game.start();
  }
}
