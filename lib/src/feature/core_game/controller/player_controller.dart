// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_state_model.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';

import '../domain/player_model.dart';
import '../repository/core_game_repository.dart';

//points to animate
const Map<int, List<int>> _snakeLadderPoints = {
  12: [29, 32],
  15: [26, 35, 46, 55],
  21: [40, 42, 59, 62, 79, 82],
  22: [38],
  54: [67, 75],
  52: [68, 67, 75],
  37: [24, 23, 22, 19],
  69: [53, 47, 34, 26, 16, 4, 3, 2],
  76: [65, 56, 46, 35, 26, 14, 13],
  87: [73, 67, 53],
  91: [89, 72, 69, 52, 49, 48],
  98: [84, 77, 64, 58, 43, 38, 23, 18, 3, 4, 5, 6, 7, 8],
};

class PlayerController extends StateNotifier<PlayerStateModel> {
  PlayerController(this.ref)
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
            isMoving: false, diceNumber: math.Random().nextInt(6) + 1,
            myPosition: -1, //only need for multiplayer
          ),
        );
  final Ref ref;
  static const _animationDuartion = Duration(milliseconds: 150);

  void setPlayer({required int playerCount}) {
    for (int i = 1; i < playerCount; i++) {
      state.players[i] = state.players[i]?.copyWith(id: i, position: 1);
    }
    state = state.copyWith(players: state.players, totalPlayers: playerCount);
  }

  Future<void> dice({bool isMutltiPlayer = false, int? currentTurnFromServer /* null if local  */}) async {
    final currentTurn = isMutltiPlayer ? currentTurnFromServer! : state.currentTurn;
    final diceNumber = math.Random().nextInt(6) + 1;

    _sendToServer(diceNumber);
    if (state.players[currentTurn]?.win == false) {
      await _moving(diceNumber);
      final currentPlayerPosition = state.players[currentTurn]?.position ?? 1;
      // Checks if winning conditions are met
      if (currentPlayerPosition == 100) {
        state.players[state.currentTurn] = state.players[state.currentTurn]?.copyWith(win: true, position: 100);
        // Declares winnner when someone wins
        Utils.showCommonSnackBar('Player ${state.currentTurn + 1} wins', width: Utils.isMobileDevice() ? null : 500);
        state = state.copyWith(players: state.players, someoneWins: true);
        return;
      }
    }

    state = state.copyWith(players: state.players, currentTurn: state.currentTurn + 1);

    if (state.currentTurn >= state.totalPlayers) {
      state = state.copyWith(currentTurn: 0);
    }
  }

  //  Function for moving player avatars
  Future<void> _moving(int diceNumber) async {
    state = state.copyWith(isMoving: true, diceNumber: diceNumber);
    final currentTurn = state.currentTurn;
    bool scoreLargerThan100 = false; // Toggle switch for moving backwards when score > 100

    for (int i = 0; i < diceNumber; i++) {
      await Future.delayed(_animationDuartion);

      final currentPlayerPosition = state.players[currentTurn]?.position ?? 1;

      // Moves backwards if score larger than 100
      if (scoreLargerThan100) {
        state.players[currentTurn] = state.players[state.currentTurn]?.copyWith(position: currentPlayerPosition - 1);
      } else {
        state.players[currentTurn] = state.players[state.currentTurn]?.copyWith(position: currentPlayerPosition + 1);
      }
      state = state.copyWith(players: state.players);

      // Activate toggle-switch if score is exceeding 100 and loop has not stopped yet
      // We can't use currentPlayerPosition here since we need the recently updated value
      // And currentPlayerPosition value is updated only when the loop is re/started
      if (state.players[currentTurn]?.position == 100) {
        scoreLargerThan100 = true;
      }
    }

    //  Moves player to endpoint of the snake or ladder
    final snakeOrLadderPosition = _snakeLadderPoints[state.players[currentTurn]?.position ?? 1];
    if (snakeOrLadderPosition != null) {
      for (int i = 0; i < snakeOrLadderPosition.length; i++) {
        await Future.delayed(_animationDuartion);
        state.players[currentTurn] = state.players[currentTurn]?.copyWith(
          position: snakeOrLadderPosition[i],
        );
        state = state.copyWith(players: state.players);
      }
    }
    state = state.copyWith(isMoving: false);
  }

  void setMyPoistion(int position) {
    state = state.copyWith(myPosition: position);
  }

  void _sendToServer(int diceNumber) {
    final payload = {
      'dice_num': diceNumber,
      'my_turn': state.myPosition,
    };
    ref.read(gameWebSocketProvider).sink.add(jsonEncode(payload));
  }
}

final playerControllerProvider = StateNotifierProvider<PlayerController, PlayerStateModel>((ref) {
  return PlayerController(ref);
});
