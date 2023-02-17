import 'package:flutter/material.dart';

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
  });
  final Color color;
  final String number;
  final bool player1IsAt;
  final bool? player2IsAt;
  final bool? player3IsAt;
  final bool? player4IsAt;
  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    return Container(
      decoration: BoxDecoration(
          color: color, border: Border.all(color: Colors.black, width: .5)),
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        children: [
          Align(
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
          if (player1IsAt)
            const Positioned(
              left: 5,
              bottom: 5,
              child: _PlayerCircle(
                color: Colors.purple,
              ),
            ),
          if (player2IsAt ?? false)
            Positioned(
              left: isDesktop ? 25 : 15,
              bottom: 5,
              child: const _PlayerCircle(
                color: Colors.pink,
              ),
            ),
          if (player3IsAt ?? false)
            Positioned(
              left: 5,
              bottom: isDesktop ? 25 : 15,
              child: const _PlayerCircle(
                color: Colors.greenAccent,
              ),
            ),
          if (player4IsAt ?? false)
            Positioned(
              left: isDesktop ? 25 : 15,
              bottom: isDesktop ? 25 : 15,
              child: const _PlayerCircle(
                color: Colors.cyanAccent,
              ),
            ),
        ],
      ),
    );
  }
}

class _PlayerCircle extends StatelessWidget {
  const _PlayerCircle({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    return Material(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 10 : 5),
      ),
    );
  }
}
