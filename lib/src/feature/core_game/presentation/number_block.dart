import 'package:flutter/material.dart';

class NumberBlock extends StatelessWidget {
  const NumberBlock({
    super.key,
    required this.color,
    required this.number,
  });
  final Color color;
  final String number;
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
