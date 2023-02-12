// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_snake_game/src/feature/core_game/domain/player_model.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'players': players.map((x) => x?.toMap()).toList(),
      'currentTurn': currentTurn,
      'totalPlayers': totalPlayers,
    };
  }

  factory PlayerStateModel.fromMap(Map<String, dynamic> map) {
    return PlayerStateModel(
      players: List<PlayerModel?>.from(
        (map['players'] as List<int>).map<PlayerModel?>(
          (x) => PlayerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      currentTurn: map['currentTurn'] as int,
      totalPlayers: map['totalPlayers'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerStateModel.fromJson(String source) =>
      PlayerStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [players, currentTurn, totalPlayers];
}
