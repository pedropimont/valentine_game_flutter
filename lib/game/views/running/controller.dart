import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

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

  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  Controller(this.game) : super() {
    avatar = Avatar(this);
    pauseResumeButton = PauseResumeButton(this);

    size = game.size;
    laneWidth = size.width / laneQuantity;

    components..add(avatar)..add(pauseResumeButton);
  }

  @override
  void update(double t) {
    if (!paused) {
      super.update(t);
    }
  }
}
