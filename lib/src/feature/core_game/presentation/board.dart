import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/widgets/snake_and_ladders.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';
import 'number_block.dart';

//index and points on ui
const Map<int, int> _numbers = {
  0: 100,
  1: 99,
  2: 98,
  3: 97,
  4: 96,
  5: 95,
  6: 94,
  7: 93,
  8: 92,
  9: 91,
  10: 81,
  11: 82,
  12: 83,
  13: 84,
  14: 85,
  15: 86,
  16: 87,
  17: 88,
  18: 89,
  19: 90,
  20: 80,
  21: 79,
  22: 78,
  23: 77,
  24: 76,
  25: 75,
  26: 74,
  27: 73,
  28: 72,
  29: 71,
  30: 61,
  31: 62,
  32: 63,
  33: 64,
  34: 65,
  35: 66,
  36: 67,
  37: 68,
  38: 69,
  39: 70,
  40: 60,
  41: 59,
  42: 58,
  43: 57,
  44: 56,
  45: 55,
  46: 54,
  47: 53,
  48: 52,
  49: 51,
  50: 41,
  51: 42,
  52: 43,
  53: 44,
  54: 45,
  55: 46,
  56: 47,
  57: 48,
  58: 49,
  59: 50,
  60: 40,
  61: 39,
  62: 38,
  63: 37,
  64: 36,
  65: 35,
  66: 34,
  67: 33,
  68: 32,
  69: 31,
  70: 21,
  71: 22,
  72: 23,
  73: 24,
  74: 25,
  75: 26,
  76: 27,
  77: 28,
  78: 29,
  79: 30,
  80: 20,
  81: 19,
  82: 18,
  83: 17,
  84: 16,
  85: 15,
  86: 14,
  87: 13,
  88: 12,
  89: 11,
  90: 1,
  91: 2,
  92: 3,
  93: 4,
  94: 5,
  95: 6,
  96: 7,
  97: 8,
  98: 9,
  99: 10,
};

class Board extends StatelessWidget {
  const Board({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: LayoutBuilder(builder: (context, constrants) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Stack(
              children: const [
                _BoardGridView(onlyPlayers: false),
                SnakeAndLadders(),
                _BoardGridView(onlyPlayers: true),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _BoardGridView extends StatelessWidget {
  const _BoardGridView({required this.onlyPlayers});
  final bool onlyPlayers;
  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    final evenColor = Theme.of(context).colorScheme.primary.withOpacity(.5);
    final oddColor = Theme.of(context).colorScheme.primary.withOpacity(.3);
    return Padding(
      padding: EdgeInsets.only(top: isDesktop ? 0 : 10),
      child: Consumer(builder: (context, ref, _) {
        final playerList = ref.watch(playerControllerProvider).players;
        return GridView.builder(
          physics: isDesktop
              ? const ClampingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return NumberBlock(
              player1IsAt: _numbers[index] == playerList[0]?.position,
              player2IsAt: _numbers[index] == playerList[1]?.position,
              player3IsAt: _numbers[index] == playerList[2]?.position,
              player4IsAt: _numbers[index] == playerList[3]?.position,
              color: _numbers[index]!.isEven ? evenColor : oddColor,
              number: _numbers[index].toString(),
              onlyPlayers: onlyPlayers,
            );
          },
          itemCount: _numbers.length,
        );
      }),
    );
  }
}
