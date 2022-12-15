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
    Future.delayed(const Duration(seconds: 1), () => updateStates(player));
  }

  void handleUserInput(int player, int blockIndex) {
    if (player == 1) {
      if (playerOneIsTapped[blockIndex] == false &&
          playerOneTappedColors.length < 4) {
        playerOneTappedColors[blockIndex] = colorsPlayerOne[blockIndex];
        playerOneIsTapped[blockIndex] = true;
        notifyListeners();
      }
    } else {
      if (playerTwoIsTapped[blockIndex] == false &&
          playerTwoTappedColors.length < 4) {
        playerTwoTappedColors[blockIndex] = colorsPlayerTwo[blockIndex];
        playerTwoIsTapped[blockIndex] = true;
        notifyListeners();
      }
    }
  }

  void updateStates(int player) {
    if (player == 1) {
      if (playerOneTappedColors.length == 4) {
        if (playerOneTappedColors.values.elementAt(0) ==
                playerOneTappedColors.values.elementAt(1) &&
            playerOneTappedColors.values.elementAt(0) ==
                playerOneTappedColors.values.elementAt(2) &&
            playerOneTappedColors.values.elementAt(0) ==
                playerOneTappedColors.values.elementAt(3)) {
          playerOneColorMatched = true;
          notifyListeners();
          colorsMatched(player);
        } else {
          playerOneTappedColors.clear();
          playerOneIsTapped =
              List<bool>.filled(playerOneIsTapped.length, false);
          notifyListeners();
        }
      }
    } else {
      if (playerTwoTappedColors.length == 4) {
        if (playerTwoTappedColors.values.elementAt(0) ==
                playerTwoTappedColors.values.elementAt(1) &&
            playerTwoTappedColors.values.elementAt(0) ==
                playerTwoTappedColors.values.elementAt(2) &&
            playerTwoTappedColors.values.elementAt(0) ==
                playerTwoTappedColors.values.elementAt(3)) {
          playerTwoColorMatched = true;
          notifyListeners();
          colorsMatched(player);
        } else {
          playerTwoTappedColors.clear();
          playerTwoIsTapped =
              List<bool>.filled(playerTwoIsTapped.length, false);
          notifyListeners();
        }
      }
    }
  }

  void colorsMatched(int player) {
    if (player == 1) {
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
      Future.delayed(const Duration(seconds: 2), () {
        playerOneColorMatched = false;
        notifyListeners();
      });
    } else {
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
      Future.delayed(const Duration(seconds: 2), () {
        playerTwoColorMatched = false;
        notifyListeners();
      });
    }
  }
}
