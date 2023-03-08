import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/common/common_widgets/common_button.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/game.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/repository/core_game_repository.dart';
import 'package:flutter_snake_and_ladder_game/src/utils.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  const LobbyScreen({super.key});

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  int time = -1;

  void setTimer({required int players, required int timer}) {
    setState(() {
      time = timer;
    });
    if (time == 0) {
      ref.read(playerControllerProvider.notifier).setPlayer(playerCount: players);
      Utils.pagePusher(context: context, page: const Game(), replaceRoute: true);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lobbySocket = ref.watch(listenLobbySocketProvider);
    final myIndex = ref.watch(playerControllerProvider).myPosition;
    ref.listen(listenLobbySocketProvider, (_, state) {
      state.whenOrNull(
        data: (data) {
          setTimer(players: data.data!.length, timer: data.timer!);
          if (data.timer == -1) {
            ref.read(playerControllerProvider.notifier).setMyPoistion(data.you!);
          }
        },
      );
    });
    return Scaffold(
        appBar: AppBar(title: const Text('Lobby')),
        body: Center(
          child: Column(
            children: [
              Center(
                child: lobbySocket.when(
                  data: (data) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: ListView.separated(
                            separatorBuilder: (_, __) => const SizedBox(
                              width: 5,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              final bgColor = Game.playerColors[index] ?? Theme.of(context).colorScheme.primary;
                              final item = data.data![index];
                              final isMe = myIndex == index;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (item.isHost!)
                                    Icon(
                                      Icons.star,
                                      color: bgColor,
                                    ),
                                  Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: isMe ? null : bgColor,
                                      border: Border.all(color: isMe ? bgColor : Colors.transparent, width: 2),
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: bgColor,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          item.name!,
                                          style: TextStyle(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            shrinkWrap: true,
                            itemCount: data.data!.length,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (data.host!)
                          CommonButton(
                            onSubmit: () {
                              ref.read(lobbyWebSocketProvider).sink.add('start');
                            },
                            child: const Text('Start Game'),
                          ),
                        const SizedBox(height: 20),
                        if (time != -1)
                          Text(
                            'Game Starts in - ${time.toString()}',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                          ),
                      ],
                    );
                  },
                  error: (e, st) => Text(
                    '$e',
                    style: const TextStyle(color: Colors.red),
                  ),
                  loading: () => const CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ));
  }
}
