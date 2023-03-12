import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/board.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/widgets/dice_roll_widget.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../repository/core_game_repository.dart';

class Game extends ConsumerStatefulWidget {
  const Game({
    super.key,
    this.isMultiplayer = false,
  });
  static const Map<int, Color> playerColors = {
    0: Colors.purple,
    1: Colors.pink,
    2: Colors.green,
    3: Colors.cyan,
  };

  final bool isMultiplayer;

  @override
  ConsumerState<Game> createState() => _GameState();
}

class _GameState extends ConsumerState<Game> {
  @override
  void initState() {
    super.initState();
    assignSelf();
  }

  void assignSelf() {
    final position = ref.read(playerControllerProvider).myPosition;
    final payload = {
      'dice_num': -1,
      'my_turn': position,
    };
    ref.read(gameWebSocketProvider).sink.add(jsonEncode(payload));
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    final playerController = ref.watch(playerControllerProvider);
    ref.listen(listenGameWebSocketProvider, (_, state) {});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake And Ladder'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isDesktop ? 55 : 15),
            ResponsiveRowColumn(
              layout: isDesktop ? ResponsiveRowColumnType.ROW : ResponsiveRowColumnType.COLUMN,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ResponsiveRowColumnItem(
                  child: Board(),
                ),
                ResponsiveRowColumnItem(
                  child: OrientationBuilder(
                    builder: (context, orientation) {
                      return SizedBox(
                        width: isDesktop ? 200 : null,
                        child: Padding(
                          padding: EdgeInsets.only(left: isDesktop ? 10 : 25, top: 10, right: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                itemBuilder: (context, index) {
                                  final isMe = playerController.myPosition == index;
                                  final currentTurn = playerController.currentTurn == index;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Game.playerColors[index],
                                        ),
                                        padding: const EdgeInsets.all(5),
                                      ),
                                      const SizedBox(width: 3),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          '${orientation == Orientation.landscape && Utils.isMobileDevice() ? 'P' : 'Player'} ${index + 1} - ${playerController.players[index]?.position ?? 0} ',
                                          style: TextStyle(
                                            color: currentTurn ? Game.playerColors[index] : null,
                                          ),
                                        ),
                                      ),
                                      if (isMe)
                                        const Text('(You)')
                                      else
                                        const Text(
                                          '(You)',
                                          style: TextStyle(color: Colors.white),
                                        )
                                    ],
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: playerController.players.where((element) => element?.position != null).toList().length,
                              ),
                              const Divider(),
                              Text('Player ${ref.watch(playerControllerProvider).currentTurn + 1}\'s turn'),
                              const SizedBox(height: 5),
                              widget.isMultiplayer
                                  ? ref.watch(listenGameWebSocketProvider).when(
                                        data: (data) {
                                          final isMyTurn = playerController.myPosition == data.currentTurn;
                                          if (data.canStart == false) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          return DiceRollWidget(
                                            enabled: isMyTurn,
                                            isMultiplayer: widget.isMultiplayer,
                                          );
                                        },
                                        error: (e, st) => Text(
                                          '$e',
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                        loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                  : DiceRollWidget(
                                      enabled: true,
                                      isMultiplayer: widget.isMultiplayer,
                                    ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
