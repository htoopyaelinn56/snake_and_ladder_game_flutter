import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.onSubmit,
      this.width = 200,
      this.height = 50,
      this.child});
  final void Function()? onSubmit;
  final double width;
  final double height;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onSubmit,
      child: child,
    );
  }
}
