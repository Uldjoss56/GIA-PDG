import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: myPink,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: myPink),
        border: InputBorder.none,
      ),
    );
  }
}
