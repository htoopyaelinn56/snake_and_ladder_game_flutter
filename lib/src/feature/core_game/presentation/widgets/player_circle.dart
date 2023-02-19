import 'package:flutter/material.dart';

import '../../../../utils.dart';

class PlayerCircle extends StatelessWidget {
  const PlayerCircle({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    return Material(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 10 : 7),
      ),
    );
  }
}
