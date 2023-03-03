import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  const Dice({super.key, required this.number})
      : assert(number >= 1 && number <= 6);
  final int number;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: number == 1
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: () {
          if (number == 1) {
            return [
              const _Dots(),
            ];
          } else if (number == 2) {
            return const [
              Align(
                alignment: Alignment.topLeft,
                child: _Dots(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _Dots(),
              ),
            ];
          } else if (number == 3) {
            return const [
              Align(
                alignment: Alignment.topLeft,
                child: _Dots(),
              ),
              Align(
                alignment: Alignment.center,
                child: _Dots(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: _Dots(),
              ),
            ];
          } else if (number == 4) {
            return [
              Row(
                children: const [
                  _Dots(),
                  Spacer(),
                  _Dots(),
                ],
              ),
              const Spacer(),
              Row(
                children: const [
                  _Dots(),
                  Spacer(),
                  _Dots(),
                ],
              ),
            ];
          } else if (number == 5) {
            return [
              Row(
                children: const [
                  _Dots(),
                  Spacer(),
                  _Dots(),
                ],
              ),
              const _Dots(),
              Row(
                children: const [
                  _Dots(),
                  Spacer(),
                  _Dots(),
                ],
              ),
            ];
          } else {
            return [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Dots(),
                  _Dots(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Dots(),
                  _Dots(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Dots(),
                  _Dots(),
                ],
              ),
            ];
          }
        }(),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
    );
  }
}
