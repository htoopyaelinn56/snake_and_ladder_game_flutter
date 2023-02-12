import 'package:flutter/material.dart';
import 'package:flutter_snake_game/src/utils.dart';

final _numbers = [for (int i = 1; i <= 100; i++) i];

class Board extends StatelessWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context) {
    final evenColor = Theme.of(context).colorScheme.primary.withOpacity(.8);
    final oddColor = Theme.of(context).colorScheme.primary.withOpacity(.5);
    return InteractiveViewer(
      panEnabled: !Utils.isDesktop(),
      scaleEnabled: !Utils.isDesktop(),
      minScale: 0.1,
      maxScale: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(builder: (context, constrants) {
          return Container(
            constraints: Utils.isDesktop()
                ? const BoxConstraints(
                    maxWidth: 650, minWidth: 650, maxHeight: 750)
                : null,
            child: Stack(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: index.isEven ? evenColor : oddColor,
                      child: Center(
                        child: Text(
                          '${_numbers[index]}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _numbers.length,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
