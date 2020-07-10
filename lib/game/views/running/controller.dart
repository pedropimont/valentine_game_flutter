import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:valentinegameflutter/game/views/running/enemies.dart';

import '../../game.dart';
import '../../config.dart' as Config;
import 'avatar.dart';
import 'pauseResumeButton.dart';

class Controller extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  bool paused = false;
  Avatar avatar;
  PauseResumeButton pauseResumeButton;
  Enemy enemy;

  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  Controller(this.game) : super() {
    size = game.size;
    laneWidth = size.width / laneQuantity;

    avatar = Avatar(this);
    pauseResumeButton = PauseResumeButton(this);
    enemy = Enemy(this);

    components..add(avatar)..add(pauseResumeButton)..add(enemy);
  }

  @override
  void update(double t) {
    if (!paused) {
      super.update(t);
    }
  }
}
