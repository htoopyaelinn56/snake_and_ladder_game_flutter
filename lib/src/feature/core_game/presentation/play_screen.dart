import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_game/main.dart';
import 'package:flutter_snake_game/src/common/common_button.dart';
import 'package:flutter_snake_game/src/feature/core_game/controller/player_controller.dart';
import 'package:flutter_snake_game/src/feature/core_game/presentation/game.dart';

import '../../../utils.dart';

enum _PlayerType {
  twoPlayer,
  threePlayer,
  fourPlayer,
}

class PlayScreen extends ConsumerStatefulWidget {
  const PlayScreen({super.key});

  @override
  ConsumerState<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends ConsumerState<PlayScreen> {
  _PlayerType type = _PlayerType.twoPlayer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton(
              segments: const [
                ButtonSegment(
                  value: _PlayerType.twoPlayer,
                  label: Text('Two Player'),
                ),
                ButtonSegment(
                  value: _PlayerType.threePlayer,
                  label: Text('Three Player'),
                ),
                ButtonSegment(
                  value: _PlayerType.fourPlayer,
                  label: Text('Four Player'),
                ),
              ],
              onSelectionChanged: (value) {
                type = value.first;

                setState(() {});
              },
              selected: {type},
            ),
            const SizedBox(height: 15),
            CommonButton(
              onSubmit: () {
                ref.read(playerControllerProvider.notifier).setPlayer(
                    playerCount: _PlayerType.values.indexOf(type) + 2);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Game(),
                    ),
                    (route) => false);
              },
              child: const Text('Play'),
            ),
          ],
        ),
      ),
    );
  }
}
