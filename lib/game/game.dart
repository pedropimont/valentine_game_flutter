import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';

import 'background.dart';
import 'views/initial/initialView.dart';

enum View { initial, running, gameOver }

class ValentineGame extends BaseGame with HasTapableComponents {
  Background background;
  InitialView initialView;
  View currentView;

  ValentineGame() {
    currentView = View.initial;
    background = Background();
    initialView = InitialView(this);
    this..add(background)..add(initialView);
  }

  void start() {
    // TODO: Implement Start Game
    print('starting game');
    currentView = View.running;
  }

  @override
  bool debugMode() {
    return false;
  }
}
