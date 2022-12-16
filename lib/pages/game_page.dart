import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rendering_testing/gameLogic.dart';
import 'package:rendering_testing/widgets/black_hole.dart';
import 'package:rendering_testing/widgets/starrs.dart';
class GamePage extends StatelessWidget {
   const GamePage({super.key});



   @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (context) => GameLogic(),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Consumer<GameLogic>(
          builder: (context, value, child) {
            final playerOneWon =
                context.select((GameLogic p) => p.playerOneWon);
            final playerTwoWon =
                context.select((GameLogic p) => p.playerTwoWon);
            final playerOneColorMatch =
                context.select((GameLogic p) => p.playerOneColorMatched);
            final playerTwoColorMatch =
                context.select((GameLogic p) => p.playerTwoColorMatched);

            return
              value.playerOneWon == true || value.playerTwoWon == true
              ? Center(
                child: ElevatedButton(
                  onPressed: ()=> {
                    value.startNewGame(),
                    value.playerOneWon = false,
                    value.playerTwoWon = false,
                  },
                  child: Text("PLAY AGAIN?"),
                ),
              ):

              Stack(children: [
                Positioned(
                    top: height/2-100,
                    left: width/2-100,
                    child: blackHole(value.radius)),

              /// playerOneBoard
              Positioned(
                  top: 0,
                  left: 0,
                  child: SizedBox(
                    width: width,
                    height: height / 2,
                    child: playerTwoColorMatch == false
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: height / 2,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: context
                                      .watch<GameLogic>()
                                      .colorsPlayerOne
                                      .length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0,
                                    childAspectRatio: 1.3,
                                  ),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: () => value.gameLoop(1, index),
                                        child: Card(
                                          shadowColor: Colors.white,
                                          color:
                                              value.playerOneIsTapped[index] ==
                                                      false
                                                  ? Colors.redAccent
                                                  : value
                                                      .colorsPlayerOne[index],
                                        ),
                                      )),
                            ),
                          )
                        : RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset("assets/sofia.jpg")),
                  )),

              /// playerTwoBoard
              Positioned(
                  top: height / 2,
                  left: 0,
                  child: SizedBox(
                    width: width,
                    height: height / 2,
                    child: playerOneColorMatch == false
                        ? SizedBox(
                            height: height / 2,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                          onTap: () => value.gameLoop(2, index),
                                          child: Card(
                                            color: value.playerTwoIsTapped[
                                                        index] ==
                                                    false
                                                ? Colors.redAccent
                                                : value.colorsPlayerTwo[index],
                                          ),
                                        )),
                              ),
                            ),
                          )
                        : Image.asset("assets/gogo.jpg"),
                  )),
            ]);
          },
        )));
  }
}
