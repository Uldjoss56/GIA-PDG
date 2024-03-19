import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    Path path = Path()
      ..moveTo(
        0,
        height,
      )
      ..lineTo(
        0.90 * width,
        height,
      )
      ..quadraticBezierTo(
        0.95 * width,
        height,
        0.95 * width,
        0.8 * height,
      )
      ..lineTo(
        0.95 * width,
        0.2 * height,
      )
      ..lineTo(
        width,
        0,
      )
      ..lineTo(
        0.05 * width,
        0,
      )
      ..quadraticBezierTo(
        0,
        0,
        0,
        0.2 * height,
      )
      ..lineTo(
        0,
        height,
      );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ContainerClipper01 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;

    Path path = Path()
      ..moveTo(
        width,
        height,
      )
      ..lineTo(
        width,
        0.20 * height,
      )
      ..quadraticBezierTo(
        width,
        0,
        0.95 * width,
        0,
      )
      ..lineTo(
        0,
        0,
      )
      ..lineTo(
        0.05 * width,
        0.2 * height,
      )
      ..lineTo(
        0.05 * width,
        0.80 * height,
      )
      ..quadraticBezierTo(
        0.05 * width,
        height,
        0.1 * width,
        height,
      )
      ..lineTo(
        width,
        height,
      );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ContainerClipper02 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final widthSplit = 0.1 * width;
    final heightSplit = 0.25 * height;

    path
      ..moveTo(0, 0)
      ..quadraticBezierTo(
        0,
        heightSplit,
        2 * widthSplit,
        heightSplit,
      )
      ..lineTo(8 * widthSplit, heightSplit)
      ..quadraticBezierTo(
        width,
        heightSplit,
        width,
        0,
      )
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
