import 'package:flutter/material.dart';
import 'package:flutter_snake_game/src/board.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Board(),
          ),
        ],
      ),
    );
  }
}
