import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonText;
  final Function() onpressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: myPink,
      ),
      child: TextButton(
        onPressed: onpressed,
        style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(
              Colors.white
          ),
          shadowColor: MaterialStateProperty.all(Colors.purpleAccent),
          elevation: MaterialStateProperty.all(4),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: buttonText,
      ),
    );
  }
}
