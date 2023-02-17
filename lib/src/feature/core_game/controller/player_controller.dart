// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_state_model.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';

import '../domain/player_model.dart';

const Map<int, int> _snakeLadderPoints = {
  12: 32,
  15: 55,
  21: 82,
  22: 38,
  54: 75,
  69: 2,
  76: 13,
  87: 53,
  91: 48,
  98: 8,
};

class PlayerController extends StateNotifier<PlayerStateModel> {
  PlayerController()
      : super(
          // dont constant it because it will be modified
          PlayerStateModel(
            // ignore: prefer_const_literals_to_create_immutables
            players: [
              PlayerModel(id: 0, position: 1, win: false),
              PlayerModel(id: null, position: null, win: false),
              PlayerModel(id: null, position: null, win: false),
              PlayerModel(id: null, position: null, win: false),
            ],
            currentTurn: 0,
            totalPlayers: 1, someoneWins: false,
            isMoving: false,
          ),
        );

  void setPlayer({required int playerCount}) {
    for (int i = 1; i < playerCount; i++) {
      state.players[i] = state.players[i]?.copyWith(id: i, position: 1);
    }
    state = state.copyWith(players: state.players, totalPlayers: playerCount);
  }

  void dice() async {
    final currentTurn = state.currentTurn;
    final currentPlayerPosition = state.players[currentTurn]?.position ?? 1;
    if (state.players[currentTurn]?.win == false) {
      final number = math.Random().nextInt(6) + 1;

      await _moving(diceNumber: number);

      // Checks if winning conditions are met
      if (currentPlayerPosition == 100) {
        state.players[state.currentTurn] = state.players[state.currentTurn]
            ?.copyWith(win: true, position: 100);
        // Declares winnner when someone wins
        Utils.showCommonSnackBar('Player ${state.currentTurn + 1} wins',
            width: 500);
        state = state.copyWith(players: state.players, someoneWins: true);
        return;
      }
    }

    state = state.copyWith(
        players: state.players, currentTurn: state.currentTurn + 1);

    if (state.currentTurn >= state.totalPlayers) {
      state = state.copyWith(currentTurn: 0);
    }
  }

  //  Function for moving player avatars
  Future<void> _moving({required int diceNumber}) async {
    state = state.copyWith(isMoving: true);
    final currentTurn = state.currentTurn;
    bool scoreLargerThan100 =
        false; // Toggle switch for moving backwards when score > 100

    for (int i = 0; i < diceNumber; i++) {
      await Future.delayed(const Duration(milliseconds: 100));

      final currentPlayerPosition = state.players[currentTurn]?.position ?? 1;

      // Moves backwards if score larger than 100
      if (scoreLargerThan100) {
        state.players[currentTurn] = state.players[state.currentTurn]
            ?.copyWith(position: currentPlayerPosition - 1);
      } else {
        state.players[currentTurn] = state.players[state.currentTurn]
            ?.copyWith(position: currentPlayerPosition + 1);
      }
      state = state.copyWith(players: state.players);

      // Activate toggle-switch if score is exceeding 100 and loop is not stopped yet
      // We can't use currentPlayerPosition here since we need the recently updated value
      // And currentPlayerPosition value is updated only when the loop is re/started
      if (state.players[currentTurn]?.position == 100) {
        scoreLargerThan100 = true;
      }
    }

    //  Moves player to endpoint of the snake or ladder
    final currentPlayerRestingPosition =
        state.players[currentTurn]?.position ?? 1;
    final snakeOrLadderPosition =
        _snakeLadderPoints[currentPlayerRestingPosition];
    if (snakeOrLadderPosition != null) {
      state.players[currentTurn] =
          state.players[currentTurn]?.copyWith(position: snakeOrLadderPosition);
    }
    state = state.copyWith(isMoving: false);
  }
}

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerStateModel>((ref) {
  return PlayerController();
});