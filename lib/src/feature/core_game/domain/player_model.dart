// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final int? id;
  final int? position;
  final bool win;
  const PlayerModel({
    required this.id,
    required this.position,
    required this.win,
  });

  PlayerModel copyWith({
    int? id,
    int? position,
    bool? win,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      position: position ?? this.position,
      win: win ?? this.win,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id ?? '', position ?? '', win];
}
