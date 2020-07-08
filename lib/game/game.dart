import 'package:flame/game.dart';

import 'background.dart';

class ValentineGame extends BaseGame {
  Background background;

  ValentineGame() {
    background = Background();
    this..add(background);
  }

  @override
  bool debugMode() {
    return false;
  }
}
