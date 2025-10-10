import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({super.key, this.height = 0, this.width = 0, this.color});

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Icon(Icons.image_not_supported_rounded, color: color),
    );
  }
}
