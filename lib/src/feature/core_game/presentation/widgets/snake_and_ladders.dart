import 'package:flutter/material.dart';

import 'dart:math' as math show pi;

import 'package:flutter_snake_and_ladder_game/src/common/my_assets.dart';

class SnakeAndLadders extends StatefulWidget {
  const SnakeAndLadders({super.key});

  @override
  State<SnakeAndLadders> createState() => _SnakeAndLaddersState();
}

class _SnakeAndLaddersState extends State<SnakeAndLadders> {
  double initialPosition = -500;
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

  double _degreeToRadian(double degree) => (math.pi / 180) * degree;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final desktopSize = size.width >= 650;
    return Positioned.fill(
      child: Stack(
        children: [
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
            bottom: initialState ? initialPosition : (desktopSize ? 130 : 80),
            left: initialState ? initialPosition : (desktopSize ? 120 : 75),
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
            left: initialState ? initialPosition : (desktopSize ? 320 : 200),
            bottom: initialState ? initialPosition : (desktopSize ? 80 : 45),
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
            right: initialState ? initialPosition : (desktopSize ? 80 : 45),
            bottom: initialState ? initialPosition : (desktopSize ? 80 : 50),
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
            left: initialState ? initialPosition : (desktopSize ? 380 : 240),
            top: initialState ? initialPosition : (desktopSize ? 160 : 115),
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
            right: initialState ? initialPosition : (desktopSize ? 160 : 110),
            top: initialState ? initialPosition : (desktopSize ? 100 : 80),
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
            left: initialState ? initialPosition : (desktopSize ? 30 : 10),
            child: Image.asset(
              MyAssets.brownSnake,
              height: desktopSize ? 780 : 500,
            ),
          ),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: initialState ? initialPosition : (desktopSize ? 140 : 110),
            left: initialState ? initialPosition : (desktopSize ? 260 : 165),
            child: Image.asset(
              MyAssets.redSnake,
              height: desktopSize ? null : 260,
            ),
          ),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: initialState ? initialPosition : 30,
            right: initialState ? initialPosition : (desktopSize ? 30 : 15),
            child: Image.asset(
              MyAssets.cyanSnake,
              height: desktopSize ? null : 220,
            ),
          ),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            top: initialState ? initialPosition : (desktopSize ? 200 : 145),
            right: initialState ? initialPosition : (desktopSize ? 80 : 60),
            child: Image.asset(
              MyAssets.purpleSnake,
              height: desktopSize ? null : 270,
            ),
          ),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            right: initialState ? initialPosition : (desktopSize ? 140 : 100),
            top: initialState ? initialPosition : (desktopSize ? 100 : 75),
            child: Image.asset(
              MyAssets.blackSnake,
              height: desktopSize ? null : 120,
            ),
          ),
          AnimatedPositioned(
            duration: kThemeAnimationDuration,
            left: initialState ? initialPosition : (desktopSize ? 100 : 70),
            bottom: initialState ? initialPosition : (desktopSize ? 55 : 40),
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
    );
  }
}
