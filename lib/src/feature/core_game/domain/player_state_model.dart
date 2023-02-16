import 'package:equatable/equatable.dart';

import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_model.dart';

class PlayerStateModel extends Equatable {
  final List<PlayerModel?> players;
  final int currentTurn;
  final int totalPlayers;
  final bool someoneWins;
  final bool isMoving;
  const PlayerStateModel({
    required this.players,
    required this.currentTurn,
    required this.totalPlayers,
    required this.someoneWins,
    required this.isMoving,
  });

  PlayerStateModel copyWith({
    List<PlayerModel?>? players,
    int? currentTurn,
    int? totalPlayers,
    bool? someoneWins,
    bool? isMoving,
  }) {
    return PlayerStateModel(
      players: players ?? this.players,
      currentTurn: currentTurn ?? this.currentTurn,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      someoneWins: someoneWins ?? this.someoneWins,
      isMoving: isMoving ?? this.isMoving,
    );
  }

  @override
  List<Object> get props {
    return [
      players,
      currentTurn,
      totalPlayers,
      someoneWins,
      isMoving,
    ];
  }
}
