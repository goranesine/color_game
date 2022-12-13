import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class GameLogic extends ChangeNotifier {
  int numberOfBlocks = 16;
  List<bool> playerOneIsTapped = List.generate(16, (index) => false);
  List<bool> playerOneIsActive = List.generate(16, (index) => true);
  List<Color> colorsPlayerOne = [
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
  ];
  List<bool> playerTwoIsTapped = List.generate(16, (index) => false);
  List<bool> playerTwoIsActive = List.generate(16, (index) => true);
  List<Color> colorsPlayerTwo = [
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.pink,
  ];
  Map<int, Color> playerOneTappedColors = {};
  Map<int, Color> playerTwoTappedColors = {};
  bool playerOneColorMatched = false;
  bool playerTwoColorMatched = false;
  bool playerOneWon = false;
  bool playerTwoWon = false;

  GameLogic() {
    colorsPlayerOne.shuffle();
  }

  void gameLoop(int player, int blockIndex) {
    handleUserInput(player, blockIndex);
    Future.delayed(const Duration(seconds: 1), () => updateStatesPlayerOne());
    // updateStates();
    // redrawGraphics();
  }

  void handleUserInput(int player, int blockIndex) {
    player == 1 ? playerOneTap(blockIndex) : playerTwoTap(blockIndex);
  }

  void playerOneTap(int blockIndex) {
    if (playerOneIsTapped[blockIndex] == false &&
        playerOneTappedColors.length < 4 &&
        playerOneIsActive[blockIndex] == true) {
      playerOneTappedColors[blockIndex] = colorsPlayerOne[blockIndex];
      playerOneIsTapped[blockIndex] = true;
      notifyListeners();
    }
  }

  void playerTwoTap(int blockIndex) {
    playerTwoTappedColors[blockIndex] = colorsPlayerTwo[blockIndex];
    playerTwoIsTapped[blockIndex] == false
        ? playerTwoIsTapped[blockIndex] = true
        : playerTwoIsTapped[blockIndex] = false;
  }

  void updateStatesPlayerOne() {
    if (playerOneTappedColors.length == 4) {
      if (playerOneTappedColors.values.elementAt(0) ==
              playerOneTappedColors.values.elementAt(1) &&
          playerOneTappedColors.values.elementAt(0) ==
              playerOneTappedColors.values.elementAt(2) &&
          playerOneTappedColors.values.elementAt(0) ==
              playerOneTappedColors.values.elementAt(3)) {
        playerOneColorMatched = true;
        notifyListeners();
        playerOneColorsMatched();
      } else {
        playerOneTappedColors.clear();
        playerOneIsTapped = List<bool>.filled(playerOneIsTapped.length, false);
        notifyListeners();
      }
    }
  }

  void playerOneColorsMatched() {
    playerOneIsActive[playerOneTappedColors.keys.elementAt(0)] = false;
    playerOneIsActive[playerOneTappedColors.keys.elementAt(1)] = false;
    playerOneIsActive[playerOneTappedColors.keys.elementAt(2)] = false;
    playerOneIsActive[playerOneTappedColors.keys.elementAt(3)] = false;
    playerOneTappedColors.clear();
    playerOneIsTapped = List<bool>.filled(playerOneIsTapped.length, false);
    if (playerOneIsActive.every((element) => element == false)) {
      playerOneWon = true;
    }
    notifyListeners();
    Future.delayed(
        const Duration(seconds: 2), () => playerOneColorMatched = false);
    notifyListeners();
  }
}
