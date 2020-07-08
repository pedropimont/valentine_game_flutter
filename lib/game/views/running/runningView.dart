import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../config.dart' as Config;
import '../../game.dart';
import 'controller.dart';
import 'avatar.dart';

class RunningView extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;
  Controller controller;
  Avatar avatar;

  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  RunningView(this.game) : super() {
    controller = Controller(game);
    avatar = Avatar(this);

    components..add(avatar);
    laneWidth = game.size.width / laneQuantity;
    this.size = game.size;
    components..add(controller)..add(avatar);
  }
}
