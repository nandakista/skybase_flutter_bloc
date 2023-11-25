import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skybase/core/extension/string_extension.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/media/preview/media_preview_page.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

enum ShapeImage { oval, react, circle }

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class SkyImage extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final double? size;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final Color? color;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Alignment alignment;
  final ShapeImage shapeImage;

  /// Called this placeholder src when [src] is null or empty
  final String? placeholderSrc;

  /// BoxFit for placeholder
  final BoxFit? placeholderFit;

  /// Custom widget that called when [src] is null or empty
  final Widget? placeholderWidget;

  /// if true -> enable on tap to redirect MediaPreview Page
  final bool enablePreview;
  final String? previewTitle;
  final TextStyle? previewTitleStyle;

  /// When your src image from asset but not from dir **assets/images/..**
  /// you need to set this to true manually
  final bool isAsset;

  /// Fill this to generated network image source by given Name.
  /// If you fill this field and [placeholderSrc], the placeholderSrc will not work
  final String? generateByName;

  const SkyImage({
    super.key,
    this.src,
    this.width,
    this.height,
    this.onTap,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.enablePreview = false,
    this.placeholderFit,
    this.placeholderWidget,
    this.placeholderSrc,
    this.isAsset = false,
    this.color,
    this.previewTitle,
    this.previewTitleStyle,
    this.errorWidget,
    this.loadingWidget,
    this.shapeImage = ShapeImage.react,
    this.alignment = Alignment.center,
    this.size,
    this.generateByName,
  });

  @override
  Widget build(BuildContext context) {
    if (src.isNotNullAndNotEmpty) {
      return BaseImage(
        src: src.toString(),
        width: width,
        height: height,
        fit: fit,
        borderRadius: borderRadius,
        enablePreview: enablePreview,
        onTapImage: onTap,
        isAsset: isAsset,
        color: color,
        previewTitle: previewTitle,
        previewTitleStyle: previewTitleStyle,
        errorWidget: errorWidget,
        loadingWidget: loadingWidget,
        shapeImage: shapeImage,
        alignment: alignment,
        size: size,
      );
    } else {
      return placeholderWidget ??
          BaseImage(
            src: generateByName.isNotNullAndNotEmpty
                ? MediaHelper.generateAvatarByName(generateByName ?? 'user')
                : placeholderSrc ?? 'assets/images/img_empty.png',
            width: width,
            height: height,
            fit: placeholderFit ?? BoxFit.contain,
            borderRadius: borderRadius,
            enablePreview: enablePreview,
            onTapImage: onTap,
            isAsset: isAsset,
            previewTitle: previewTitle,
            previewTitleStyle: previewTitleStyle,
            shapeImage: shapeImage,
            alignment: alignment,
            size: size,
          );
    }
  }
}

class BaseImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final double? size;
  final VoidCallback? onTapImage;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;
  final bool enablePreview;
  final bool isAsset;
  final Color? color;
  final String? previewTitle;
  final TextStyle? previewTitleStyle;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final ShapeImage shapeImage;
  final Alignment alignment;

  const BaseImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.onTapImage,
    this.borderRadius,
    this.fit = BoxFit.fill,
    this.enablePreview = false,
    this.isAsset = false,
    this.color,
    this.previewTitle,
    this.previewTitleStyle,
    this.errorWidget,
    this.loadingWidget,
    this.shapeImage = ShapeImage.react,
    this.alignment = Alignment.center,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (shapeImage == ShapeImage.circle) {
      assert(
        size != null,
        "Size cannot be null if shapeImage is ShapeImage.circle, ",
      );
    }

    return GestureDetector(
      onTap: enablePreview
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaPreviewPage(
                    src: src,
                    isAsset: isAsset,
                    title: previewTitle,
                    titleStyle: previewTitleStyle,
                  ),
                ),
              )
          : onTapImage,
      child: _determineShapeImage(),
    );
  }

  Widget _determineShapeImage() {
    return switch (shapeImage) {
      ShapeImage.oval => ClipOval(child: _determineImageWidget()),
      ShapeImage.circle => CircleAvatar(
          radius: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size!),
            child: _determineImageWidget(),
          ),
        ),
      ShapeImage.react => ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: _determineImageWidget(),
        ),
    };
  }

  Widget _determineImageWidget() {
    final isFromRemote = src.startsWith('http');
    final isSvg = src.endsWith('svg');
    final isAssets = isAsset || src.startsWith('assets/images/');

    if (isSvg) {
      return SvgPicture.asset(
        src,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit,
        alignment: alignment,
      );
    } else if (isFromRemote) {
      return CachedNetworkImage(
        imageUrl: src,
        color: color,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        placeholder: (context, url) => SizedBox(
          height: height,
          width: width,
          child: loadingWidget ?? const PlatformLoadingIndicator(),
        ),
        errorWidget: (context, url, error) {
          debugPrint('Error load network image $url $error');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else if (isAssets) {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        errorBuilder: (context, err, stackTrace) {
          debugPrint('Error load asset image $err');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else {
      return Image.file(
        File(src),
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        errorBuilder: (context, err, stackTrace) {
          debugPrint('Error load file image $err');
          return SizedBox(
            height: height,
            width: width,
            child: errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    }
  }
}
