import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/player_controller.dart';
import 'dice.dart';

class DiceRollWidget extends ConsumerStatefulWidget {
  const DiceRollWidget({super.key});

  @override
  ConsumerState<DiceRollWidget> createState() => _DiceRollWidgetState();
}

class _DiceRollWidgetState extends ConsumerState<DiceRollWidget>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(vsync: this);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerController = ref.watch(playerControllerProvider);
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: playerController.someoneWins ||
              playerController.isMoving ||
              animationController.isAnimating 
          ? null
          : () async {
              animationController.value = 0;
              animationController.forward().then((value) {
                ref.read(playerControllerProvider.notifier).dice();
              });
            },
      child: Dice(number: ref.watch(playerControllerProvider).diceNumber)
          .animate(
            controller: animationController,
          )
          .shake(
            duration: 1.seconds,
            hz: 5,
            rotation: .15,
          ),
    );
  }
}
