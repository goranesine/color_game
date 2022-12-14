import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class GameLogic extends ChangeNotifier {
  int numberOfBlocks = 16;
  List<bool> playerOneIsTapped = List.generate(16, (index) => false);
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
  //  colorsPlayerOne.shuffle();
  //  colorsPlayerTwo.shuffle();
  }

  void startNewGame() {
    numberOfBlocks = 16;
    playerOneIsTapped = List.generate(16, (index) => false);
    colorsPlayerOne = [
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
    playerTwoIsTapped = List.generate(16, (index) => false);
    colorsPlayerTwo = [
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
    playerOneTappedColors = {};
    playerTwoTappedColors = {};
    playerOneColorMatched = false;
    playerTwoColorMatched = false;
    playerOneWon = false;
    playerTwoWon = false;
  }

  void gameLoop(int player, int blockIndex) {
    handleUserInput(player, blockIndex);
    player == 1
        ? Future.delayed(
            const Duration(seconds: 1), () => updateStatesPlayerOne())
        : Future.delayed(
            const Duration(seconds: 1), () => updateStatesPlayerTwo());
  }

  void handleUserInput(int player, int blockIndex) {
    player == 1 ? playerOneTap(blockIndex) : playerTwoTap(blockIndex);
  }

  void playerOneTap(int blockIndex) {
    if (playerOneIsTapped[blockIndex] == false &&
        playerOneTappedColors.length < 4) {
      playerOneTappedColors[blockIndex] = colorsPlayerOne[blockIndex];
      playerOneIsTapped[blockIndex] = true;
      notifyListeners();
    }
  }

  void playerTwoTap(int blockIndex) {
    if (playerTwoIsTapped[blockIndex] == false &&
        playerTwoTappedColors.length < 4) {
      playerTwoTappedColors[blockIndex] = colorsPlayerTwo[blockIndex];
      playerTwoIsTapped[blockIndex] = true;
      notifyListeners();
    }
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

  void updateStatesPlayerTwo() {
    if (playerTwoTappedColors.length == 4) {
      if (playerTwoTappedColors.values.elementAt(0) ==
              playerTwoTappedColors.values.elementAt(1) &&
          playerTwoTappedColors.values.elementAt(0) ==
              playerTwoTappedColors.values.elementAt(2) &&
          playerTwoTappedColors.values.elementAt(0) ==
              playerTwoTappedColors.values.elementAt(3)) {
        playerTwoColorMatched = true;
        notifyListeners();
        playerTwoColorsMatched();
      } else {
        playerTwoTappedColors.clear();
        playerTwoIsTapped = List<bool>.filled(playerTwoIsTapped.length, false);
        notifyListeners();
      }
    }
  }

  void playerOneColorsMatched() {
    colorsPlayerOne
        .removeWhere((element) => element == playerOneTappedColors[0]);
    colorsPlayerOne
        .removeWhere((element) => element == playerOneTappedColors[1]);
    colorsPlayerOne
        .removeWhere((element) => element == playerOneTappedColors[2]);
    colorsPlayerOne
        .removeWhere((element) => element == playerOneTappedColors[3]);

    playerOneTappedColors.clear();
    playerOneIsTapped = List<bool>.filled(playerOneIsTapped.length, false);
    if (colorsPlayerOne.isEmpty) {
      playerOneWon = true;
    }
    notifyListeners();
    Future.delayed(
        const Duration(seconds: 2), () => playerOneColorMatched = false);
    notifyListeners();
  }

  void playerTwoColorsMatched() {
    colorsPlayerTwo
        .removeWhere((element) => element == playerTwoTappedColors[0]);
    colorsPlayerTwo
        .removeWhere((element) => element == playerTwoTappedColors[1]);
    colorsPlayerTwo
        .removeWhere((element) => element == playerTwoTappedColors[2]);
    colorsPlayerTwo
        .removeWhere((element) => element == playerTwoTappedColors[3]);

    playerTwoTappedColors.clear();
    playerTwoIsTapped = List<bool>.filled(playerTwoIsTapped.length, false);
    if (colorsPlayerTwo.isEmpty) {
      playerTwoWon = true;
    }
    notifyListeners();
    Future.delayed(
        const Duration(seconds: 2), () => playerTwoColorMatched = false);
    notifyListeners();
  }
}
