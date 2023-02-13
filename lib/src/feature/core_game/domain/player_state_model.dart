import 'package:equatable/equatable.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_model.dart';

class PlayerStateModel extends Equatable {
  final List<PlayerModel?> players;
  final int currentTurn;
  final int totalPlayers;
  const PlayerStateModel(
      {required this.players,
      required this.currentTurn,
      required this.totalPlayers,
      s});

  PlayerStateModel copyWith({
    List<PlayerModel?>? players,
    int? currentTurn,
    int? totalPlayers,
  }) {
    return PlayerStateModel(
      players: players ?? this.players,
      currentTurn: currentTurn ?? this.currentTurn,
      totalPlayers: totalPlayers ?? this.totalPlayers,
    );
  }

  @override
  List<Object> get props => [players, currentTurn, totalPlayers];
}
