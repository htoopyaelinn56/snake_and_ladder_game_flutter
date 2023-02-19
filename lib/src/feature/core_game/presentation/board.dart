import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';
import 'dart:math' as math show pi;
import '../../../common/my_assets.dart';
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

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  double _degreeToRadian(double degree) => (math.pi / 180) * degree;
  double initialPosition = -300;
  bool initialState = true;

  @override
  void initState() {
    setPosition();
    super.initState();
  }

  void setPosition() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 300));
      initialState = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    final size = MediaQuery.of(context).size;
    final desktopSize = size.width >= 650;
    final evenColor = Theme.of(context).colorScheme.primary.withOpacity(.5);
    final oddColor = Theme.of(context).colorScheme.primary.withOpacity(.3);
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
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isDesktop ? 0 : 10),
                  child: Consumer(builder: (context, ref, _) {
                    final playerList =
                        ref.watch(playerControllerProvider).players;
                    return GridView.builder(
                      physics: isDesktop
                          ? const ClampingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return NumberBlock(
                          player1IsAt:
                              _numbers[index] == playerList[0]?.position,
                          player2IsAt:
                              _numbers[index] == playerList[1]?.position,
                          player3IsAt:
                              _numbers[index] == playerList[2]?.position,
                          player4IsAt:
                              _numbers[index] == playerList[3]?.position,
                          color: _numbers[index]!.isEven ? evenColor : oddColor,
                          number: _numbers[index].toString(),
                        );
                      },
                      itemCount: _numbers.length,
                    );
                  }),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: initialState ? initialPosition : (desktopSize ? 90 : 80),
                  left: initialState ? initialPosition : 10,
                  child: Image.asset(
                    MyAssets.orangeLadder,
                    height: desktopSize ? null : 250,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  bottom:
                      initialState ? initialPosition : (desktopSize ? 130 : 80),
                  left:
                      initialState ? initialPosition : (desktopSize ? 120 : 75),
                  child: Transform.rotate(
                    angle: _degreeToRadian(45),
                    child: Image.asset(
                      MyAssets.redLadder,
                      height: desktopSize ? 130 : 80,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  left: initialState
                      ? initialPosition
                      : (desktopSize ? 320 : 200),
                  bottom:
                      initialState ? initialPosition : (desktopSize ? 80 : 45),
                  child: Transform.rotate(
                    angle: _degreeToRadian(5),
                    child: Image.asset(
                      MyAssets.blueLadder,
                      height: desktopSize ? null : 180,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  right:
                      initialState ? initialPosition : (desktopSize ? 80 : 45),
                  bottom:
                      initialState ? initialPosition : (desktopSize ? 80 : 50),
                  child: Transform.rotate(
                    angle: _degreeToRadian(-5),
                    child: Image.asset(
                      MyAssets.redLadder,
                      height: desktopSize ? null : 95,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  left: initialState
                      ? initialPosition
                      : (desktopSize ? 380 : 240),
                  top: initialState
                      ? initialPosition
                      : (desktopSize ? 160 : 115),
                  child: Transform.rotate(
                    angle: _degreeToRadian(-30),
                    child: Image.asset(
                      MyAssets.redLadder,
                      height: desktopSize ? null : 85,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  right: initialState
                      ? initialPosition
                      : (desktopSize ? 160 : 110),
                  top:
                      initialState ? initialPosition : (desktopSize ? 100 : 80),
                  child: Transform.rotate(
                    angle: _degreeToRadian(-50),
                    child: Image.asset(
                      MyAssets.blueLadder,
                      height: desktopSize ? 260 : 150,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: initialState ? initialPosition : (desktopSize ? -15 : 0),
                  left:
                      initialState ? initialPosition : (desktopSize ? 30 : 10),
                  child: Image.asset(
                    MyAssets.brownSnake,
                    height: desktopSize ? 780 : 500,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: initialState
                      ? initialPosition
                      : (desktopSize ? 140 : 110),
                  left: initialState
                      ? initialPosition
                      : (desktopSize ? 260 : 165),
                  child: Image.asset(
                    MyAssets.redSnake,
                    height: desktopSize ? null : 260,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: initialState ? initialPosition : 30,
                  right:
                      initialState ? initialPosition : (desktopSize ? 30 : 15),
                  child: Image.asset(
                    MyAssets.cyanSnake,
                    height: desktopSize ? null : 220,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  top: initialState
                      ? initialPosition
                      : (desktopSize ? 200 : 145),
                  right:
                      initialState ? initialPosition : (desktopSize ? 80 : 60),
                  child: Image.asset(
                    MyAssets.purpleSnake,
                    height: desktopSize ? null : 270,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  right: initialState
                      ? initialPosition
                      : (desktopSize ? 140 : 100),
                  top:
                      initialState ? initialPosition : (desktopSize ? 100 : 75),
                  child: Image.asset(
                    MyAssets.blackSnake,
                    height: desktopSize ? null : 120,
                  ),
                ),
                AnimatedPositioned(
                  duration: kThemeAnimationDuration,
                  left:
                      initialState ? initialPosition : (desktopSize ? 100 : 70),
                  bottom:
                      initialState ? initialPosition : (desktopSize ? 55 : 40),
                  child: Transform.rotate(
                    angle: _degreeToRadian(65),
                    child: Image.asset(
                      MyAssets.blackSnake,
                      height: desktopSize ? null : 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
