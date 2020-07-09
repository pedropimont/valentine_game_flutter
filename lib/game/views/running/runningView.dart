import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../config.dart' as Config;
import '../../game.dart';
import 'controller.dart';
import 'avatar.dart';
import 'pauseResumeButton.dart';

class RunningView extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  Controller controller;
  Avatar avatar;
  PauseResumeButton pauseResumeButton;

  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  RunningView(this.game) : super() {
    controller = Controller(game);
    avatar = Avatar(this);
    pauseResumeButton = PauseResumeButton(controller);


    size = game.size;
    laneWidth = size.width / laneQuantity;

    components..add(controller)..add(avatar);
  }
}
