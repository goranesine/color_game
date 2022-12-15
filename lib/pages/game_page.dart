import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rendering_testing/gameLogic.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
        create: (context) => GameLogic(),
        child: Scaffold(body: Consumer<GameLogic>(
          builder: (context, value, child) {
            final playerOneWon =
                context.select((GameLogic p) => p.playerOneWon);
            final playerTwoWon =
                context.select((GameLogic p) => p.playerTwoWon);
            final playerOneColorMatch =
                context.select((GameLogic p) => p.playerOneColorMatched);
            final playerTwoColorMatch =
                context.select((GameLogic p) => p.playerTwoColorMatched);

            return Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// player one board
playerTwoColorMatch == false
                  ?
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: _height / 2,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              context.watch<GameLogic>().colorsPlayerOne.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            childAspectRatio: 1.3,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () => value.gameLoop(1, index),
                                child: Card(
                                  shadowColor: Colors.white,
                                  color: value.playerOneIsTapped[index] == false
                                      ? Colors.redAccent
                                      : value.colorsPlayerOne[index],
                                ),
                              )),
                    ),
                  )
: FlutterLogo(),


                  /// player two board
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: SizedBox(
                        height: _height / 2,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: context
                                .watch<GameLogic>()
                                .colorsPlayerTwo
                                .length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              childAspectRatio: 1.3,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => value.gameLoop(2, index),
                                  child: Card(
                                    color:
                                        value.playerTwoIsTapped[index] == false
                                            ? Colors.redAccent
                                            : value.colorsPlayerTwo[index],
                                  ),
                                )),
                      ),
                    ),
                  )
                ],
              )
            ]);
          },
        )));
  }
}
