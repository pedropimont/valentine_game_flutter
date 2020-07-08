import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game/game.dart';
import 'paths.dart' as Path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setOrientation(DeviceOrientation.portraitUp);

  runApp(MaterialApp(
    title: 'Valentine Game',
    color: Colors.white,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: GameWrapper(),
    ),
  ));
}

class GameWrapper extends StatefulWidget {
  @override
  _GameWrapperState createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  bool splashGone = false;
  ValentineGame game;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    Flame.images.loadAll(<String>[
      Path.background,
      Path.gameLogo,
      Path.startButton,
      Path.avatar,
    ]);
    game = ValentineGame();
  }

  @override
  Widget build(BuildContext context) {
    return _buildGame(context);
  }

  Widget _buildGame(BuildContext context) {
    if (game == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      color: Colors.white,
      constraints: const BoxConstraints.expand(),
      child: Container(
        child: game.widget,
      ),
    );
  }
}
