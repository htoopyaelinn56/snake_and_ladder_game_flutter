// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final int? id;
  final int? position;
  const PlayerModel({
    required this.id,
    required this.position,
  });

  PlayerModel copyWith({
    int? id,
    int? position,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'position': position,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      id: map['id'] as int,
      position: map['position'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id ?? '', position ?? ''];
}
