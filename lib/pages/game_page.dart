import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rendering_testing/gameLogic.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GameLogic(),
        child: Scaffold(
            body: Stack(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) =>
                  Consumer<GameLogic>(builder: (context, value, child) {
                return GestureDetector(
                  onTap: () => value.gameLoop(1, index),
                  child: Card(
                    color: getColor(value, index),
                  ),
                );
              }),
            ),
          ],
        )));
  }

  Color getColor(GameLogic value, int index) {
    late Color newColor;
    if (value.playerOneIsTapped[index] == false &&
        value.playerOneIsActive[index] == true) {
      newColor = Colors.redAccent;
    }
    if (value.playerOneIsTapped[index] == true &&
        value.playerOneIsActive[index] == true) {
      newColor = value.colorsPlayerOne[index];
    }
    if (value.playerOneIsActive[index] == false) {
      newColor = Colors.transparent;
    }
    return newColor;
  }
}
