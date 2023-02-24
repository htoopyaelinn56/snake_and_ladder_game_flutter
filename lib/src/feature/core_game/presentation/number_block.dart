import 'package:flutter/material.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/widgets/player_circle.dart';

import '../../../utils.dart';

class NumberBlock extends StatelessWidget {
  const NumberBlock({
    super.key,
    required this.color,
    required this.number,
    required this.player1IsAt,
    this.player2IsAt,
    this.player3IsAt,
    this.player4IsAt,
    required this.onlyPlayers,
  });
  final Color color;
  final String number;
  final bool player1IsAt;
  final bool? player2IsAt;
  final bool? player3IsAt;
  final bool? player4IsAt;
  final bool onlyPlayers;
  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    return Stack(
      children: [
        if (!onlyPlayers)
          Container(
            decoration:
                BoxDecoration(color: color, border: Border.all(width: .3)),
            padding: const EdgeInsets.only(right: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                number,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        if (onlyPlayers)
          Positioned.fill(
            child: Stack(
              children: [
                if (player1IsAt)
                  const Positioned(
                    left: 5,
                    bottom: 5,
                    child: PlayerCircle(
                      color: Colors.purple,
                    ),
                  ),
                if (player2IsAt ?? false)
                  Positioned(
                    left: isDesktop ? 25 : 15,
                    bottom: 5,
                    child: const PlayerCircle(
                      color: Colors.pink,
                    ),
                  ),
                if (player3IsAt ?? false)
                  Positioned(
                    left: 5,
                    bottom: isDesktop ? 25 : 15,
                    child: const PlayerCircle(
                      color: Colors.greenAccent,
                    ),
                  ),
                if (player4IsAt ?? false)
                  Positioned(
                    left: isDesktop ? 25 : 15,
                    bottom: isDesktop ? 25 : 15,
                    child: const PlayerCircle(
                      color: Colors.cyanAccent,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
