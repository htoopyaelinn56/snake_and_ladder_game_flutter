import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_game/src/feature/core_game/presentation/board.dart';
import 'package:flutter_snake_game/src/common/common_button.dart';
import 'package:flutter_snake_game/src/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

const List<Color> _playerColors = [
  Colors.purple,
  Colors.pink,
  Colors.greenAccent,
  Colors.cyanAccent,
];

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Utils.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake And Ladder'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isDesktop ? 55 : 15),
          Expanded(
            child: ResponsiveRowColumn(
              layout: isDesktop
                  ? ResponsiveRowColumnType.ROW
                  : ResponsiveRowColumnType.COLUMN,
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ResponsiveRowColumnItem(
                  child: Board(),
                ),
                ResponsiveRowColumnItem(
                  child: OrientationBuilder(builder: (context, orientation) {
                    return SizedBox(
                      width: isDesktop
                          ? (Utils.isMobileDevice() &&
                                  orientation == Orientation.landscape
                              ? 100
                              : 200)
                          : null,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: isDesktop ? 10 : 25, top: 10, right: 25),
                        child: Consumer(builder: (context, ref, _) {
                          final playerList =
                              ref.watch(playerControllerProvider).players;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _playerColors[index],
                                        ),
                                        padding: const EdgeInsets.all(5),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${orientation == Orientation.landscape && Utils.isMobileDevice() ? 'P' : 'Player'} ${index + 1} - ${playerList[index]?.position ?? 0} ',
                                      ),
                                    ],
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: playerList
                                    .where(
                                        (element) => element?.position != null)
                                    .toList()
                                    .length,
                              ),
                              const Divider(),
                              Text(
                                  'Player ${ref.watch(playerControllerProvider).currentTurn + 1}\'s turn'),
                              const SizedBox(height: 5),
                              CommonButton(
                                onSubmit: () {
                                  ref
                                      .read(playerControllerProvider.notifier)
                                      .dice();
                                },
                                child: const Text('Dice'),
                              ),
                            ],
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
