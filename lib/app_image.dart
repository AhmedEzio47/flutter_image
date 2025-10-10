import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_cached_image.dart';
import 'image_error.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
    this.fit = BoxFit.cover,
    this.radius = 0,
    this.errorWidget,
    this.badge,
    this.hidePlaceholderBackground = false,
  });

  final String url;
  final double? height;
  final double? width;
  final Color? color;
  final bool isFile;
  final BoxFit fit;
  final double radius;
  final Widget? errorWidget;
  final Widget? badge;
  final bool hidePlaceholderBackground;

  @override
  Widget build(BuildContext context) {
    final error =
        errorWidget ?? ImageError(height: height, width: width, color: color);

    if (url.isEmpty) return error;

    Widget image = Image.asset(
      url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      errorBuilder: (ctx, _, __) => error,
    );

    if (isFile) {
      image = Image.file(
        File(url),
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    } else if (url.contains('.svg')) {
      final colorFilter = color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null;
      image = url.contains('http')
          ? SvgPicture.network(
              url,
              height: height,
              width: width,
              colorFilter: colorFilter,
            )
          : SvgPicture.asset(
              url,
              height: height,
              width: width,
              colorFilter: colorFilter,
            );
    } else if (url.contains('http')) {
      image = CustomCachedImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        hidePlaceholderBackground: hidePlaceholderBackground,
      );
    } else if (_isBase64Image(url)) {
      String? base64String;
      if (url.startsWith('data:image/')) {
        final parts = url.split(',');
        if (parts.length > 1) {
          base64String = parts.last;
        }
      } else {
        base64String = url;
      }

      image = Image.memory(
        base64Decode(base64String ?? ''),
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }

    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: image,
        ),
        if (badge != null) Positioned(top: 0, right: 0, child: badge!),
      ],
    );
  }

  bool _isBase64Image(String url) {
    if (url.startsWith('data:image/') && url.contains('base64,')) {
      return true;
    }

    if (url.length % 4 == 0 &&
        RegExp(r'^[A-Za-z0-9+/]*={0,2}$').hasMatch(url)) {
      return true;
    }

    return false;
  }
}
