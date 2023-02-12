import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_game/main.dart';
import 'dart:math' as math;
import 'package:flutter_snake_game/src/feature/core_game/domain/player_state_model.dart';
import 'package:flutter_snake_game/src/feature/core_game/presentation/game.dart';
import 'package:flutter_snake_game/src/utils.dart';

import '../domain/player_model.dart';

class PlayerController extends StateNotifier<PlayerStateModel> {
  PlayerController()
      : super(
          PlayerStateModel(
            players: [
              PlayerModel(id: 0, position: 1),
              PlayerModel(id: null, position: null),
              PlayerModel(id: null, position: null),
              PlayerModel(id: null, position: null),
            ],
            currentTurn: 0,
            totalPlayers: 1,
          ),
        );

  void setPlayer({required int playerCount}) {
    for (int i = 1; i < playerCount; i++) {
      state.players[i] = state.players[i]?.copyWith(id: i, position: 1);
    }
    state = state.copyWith(players: state.players, totalPlayers: playerCount);
  }

  void dice() {
    final number = math.Random().nextInt(6) + 1;

    final newPosition =
        (state.players[state.currentTurn]?.position ?? 0) + number;
    state.players[state.currentTurn] =
        state.players[state.currentTurn]?.copyWith(position: newPosition);

    state = state.copyWith(
        players: state.players, currentTurn: state.currentTurn + 1);
    if (state.currentTurn >= state.totalPlayers) {
      state = state.copyWith(currentTurn: 0);
    }
  }
}

final playerControllerProvider =
    StateNotifierProvider<PlayerController, PlayerStateModel>((ref) {
  return PlayerController();
});
