import 'package:flutter/material.dart';

import 'const/colors.dart';

class Button extends StatelessWidget {
  final double? buttonWidth;
  final double? buttonHeight;
  final Widget buttonText;
  final Function()? onpressed;

  const Button({
    super.key,
    required this.buttonText,
    required this.onpressed,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          radius: 1.5,
          colors: [
            myPink,
            myPink01,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: onpressed,
        child: buttonText,
      ),
    );
  }
}
