// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_snake_and_ladder_game/src/feature/core_game/domain/player_model.dart';

class PlayerStateModel extends Equatable {
  final List<PlayerModel?> players;
  final int currentTurn;
  final int totalPlayers;
  final bool someoneWins;
  final bool isMoving;
  final int diceNumber;
  const PlayerStateModel({
    required this.players,
    required this.currentTurn,
    required this.totalPlayers,
    required this.someoneWins,
    required this.isMoving,
    required this.diceNumber,
  });

  PlayerStateModel copyWith({
    List<PlayerModel?>? players,
    int? currentTurn,
    int? totalPlayers,
    bool? someoneWins,
    bool? isMoving,
    int? diceNumber,
  }) {
    return PlayerStateModel(
      players: players ?? this.players,
      currentTurn: currentTurn ?? this.currentTurn,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      someoneWins: someoneWins ?? this.someoneWins,
      isMoving: isMoving ?? this.isMoving,
      diceNumber: diceNumber ?? 0,
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
      diceNumber,
    ];
  }
}
