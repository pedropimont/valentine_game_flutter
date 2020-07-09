import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'background.dart';
import 'views/initial/initialView.dart';
import 'views/running/runningView.dart';

enum View { initial, running, gameOver }
enum DragDirection { left, right }

class ValentineGame extends BaseGame with HasTapableComponents {
  Background background;
  InitialView initialView;
  RunningView runningView;
  DragDirection dragDirection;
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

  GestureDragUpdateCallback onHorizontalDragUpdate(DragUpdateDetails d) {
    if (d.primaryDelta > 0) {
      dragDirection = DragDirection.right;
    } else if (d.primaryDelta < 0) {
      dragDirection = DragDirection.left;
    } else {
      dragDirection = null;
    }
  }

  GestureDragEndCallback onHorizontalDragEnd(DragEndDetails d) {
    if (dragDirection != null && runningView?.avatar != null)
      runningView.avatar.handleHorizontalDragEnd(dragDirection);
  }

  @override
  void onTapUp(int pointerId, TapUpDetails d) {
    if (currentView == View.running && runningView?.avatar != null)
      runningView.avatar.handleTapUp();
    super.onTapUp(pointerId, d);
  }

  @override
  bool debugMode() {
    return false;
  }
}
