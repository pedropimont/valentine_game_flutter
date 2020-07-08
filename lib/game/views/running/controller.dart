import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';

import '../../game.dart';
import '../../config.dart' as Config;

class Controller extends PositionComponent
    with Resizable, HasGameRef, Tapable, ComposedComponent {
  ValentineGame game;

  int laneQuantity = Config.laneQuantity;
  double laneWidth;

  bool paused = false;

  Controller(this.game) : super() {
    laneWidth = game.size.width / laneQuantity;
    this.size = game.size;
  }
}
