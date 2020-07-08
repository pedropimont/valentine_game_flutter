import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';

import 'background.dart';
import 'views/initial/initialView.dart';
import 'views/running/runningView.dart';

enum View { initial, running, gameOver }

class ValentineGame extends BaseGame with HasTapableComponents {
  Background background;
  InitialView initialView;
  RunningView runningView;
  View currentView;

  ValentineGame() {
    currentView = View.initial;
    background = Background();
    initialView = InitialView(this);
    this..add(background)..add(initialView);
  }

  void start() {
    if (initialView != null) components.remove(initialView);
    if (runningView != null) components.remove(runningView);
    currentView = View.running;
    runningView = RunningView(this);
    this.add(runningView);
  }

  @override
  bool debugMode() {
    return false;
  }
}
