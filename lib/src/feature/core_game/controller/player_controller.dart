// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_state_model.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';

import '../domain/player_model.dart';

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
    if (state.players[state.currentTurn]?.win == false) {
      final number = math.Random().nextInt(6) + 1;

      await _moving(diceNumber: number);

      if ((state.players[state.currentTurn]?.position ?? -1) >= 100) {
        state.players[state.currentTurn] = state.players[state.currentTurn]
            ?.copyWith(win: true, position: 100);
      }
    }

    if (state.players[state.currentTurn]?.win == true) {
      Utils.showCommonSnackBar('Player ${state.currentTurn + 1} wins',
          width: 500);
      state = state.copyWith(players: state.players, someoneWins: true);
      return;
    }

    state = state.copyWith(
        players: state.players, currentTurn: state.currentTurn + 1);

    if (state.currentTurn >= state.totalPlayers) {
      state = state.copyWith(currentTurn: 0);
    }
  }

  Future<void> _moving({required int diceNumber}) async {
    for (int i = 0; i <= diceNumber; i++) {
      state = state.copyWith(isMoving: true);
      await Future.delayed(const Duration(milliseconds: 300));
      state.players[state.currentTurn] = state.players[state.currentTurn]
          ?.copyWith(
              position: (state.players[state.currentTurn]?.position ?? 1) + 1);
      state = state.copyWith(players: state.players);
    }
    state = state.copyWith(isMoving: false);
  }
}

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerStateModel>((ref) {
  return PlayerController();
});
