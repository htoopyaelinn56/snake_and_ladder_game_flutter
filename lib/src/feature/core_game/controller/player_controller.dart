// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_state_model.dart';

import '../domain/player_model.dart';

class PlayerController extends StateNotifier<PlayerStateModel> {
  PlayerController()
      : super(
          // dont constant it because it will be modified
          PlayerStateModel(
            // ignore: prefer_const_literals_to_create_immutables
            players: [
              PlayerModel(id: 0, position: 98, win: false),
              PlayerModel(id: null, position: null, win: false),
              PlayerModel(id: null, position: null, win: false),
              PlayerModel(id: null, position: null, win: false),
            ],
            currentTurn: 0,
            totalPlayers: 1,
          ),
        );

  void setPlayer({required int playerCount}) {
    for (int i = 1; i < playerCount; i++) {
      state.players[i] =
          state.players[i]?.copyWith(id: i, position: i == 2 ? 90 : 1);
    }
    state = state.copyWith(players: state.players, totalPlayers: playerCount);
  }

  void dice() {
    if (state.players[state.currentTurn]?.win == false) {
      final number = math.Random().nextInt(6) + 1;
      final newPosition =
          (state.players[state.currentTurn]?.position ?? 0) + number;
      state.players[state.currentTurn] =
          state.players[state.currentTurn]?.copyWith(position: newPosition);

      if ((state.players[state.currentTurn]?.position ?? -1) >= 100) {
        state.players[state.currentTurn] = state.players[state.currentTurn]
            ?.copyWith(win: true, position: 100);
      }
    }

    if (state.currentTurn != state.players.length - 1 &&
        state.players[state.currentTurn + 1]?.win == true) {
      state = state.copyWith(
          players: state.players, currentTurn: state.currentTurn + 2);
    } else {
      state = state.copyWith(
          players: state.players, currentTurn: state.currentTurn + 1);
    }

    if (state.currentTurn >= state.totalPlayers) {
      state = state.copyWith(currentTurn: 0);
      if (state.players[0]?.win == true) {
        state = state.copyWith(players: state.players, currentTurn: 1);
      }
    }
  }
}

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerStateModel>((ref) {
  return PlayerController();
});
