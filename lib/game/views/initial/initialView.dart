import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../game.dart';
import 'gameLogo.dart';
import 'startButton.dart';

class InitialView extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  StartButton startButton;
  GameLogo gameLogo;

  InitialView(this.game) : super() {
    gameLogo = GameLogo();
    startButton = StartButton(game);

    components..add(startButton)..add(gameLogo);
  }
}
