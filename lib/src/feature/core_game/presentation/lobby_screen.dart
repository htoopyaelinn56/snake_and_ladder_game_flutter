import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/repository/core_game_repository.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lobby')),
      body: Consumer(builder: (context, ref, _) {
        final lobbySocket = ref.watch(listenLobbySocketProvider);
        return Column(
          children: [
            lobbySocket.when(
              data: (data) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    final item = data.players![index];
                    return Text(item.data!);
                  },
                  shrinkWrap: true,
                  itemCount: data.players!.length,
                );
              },
              error: (e, st) => Text(
                '$e $st',
                style: const TextStyle(color: Colors.red),
              ),
              loading: () => const CircularProgressIndicator(),
            )
          ],
        );
      }),
    );
  }
}
