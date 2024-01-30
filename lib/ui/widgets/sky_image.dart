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

  /// Retry source image when network get 401 or 403
  final Future<String?> Function()? onRetrySrc;

  /// Max retry attempt count for [onRetrySrc]
  final int maxRetryCount;

  /// Timeout for retry network image
  final Duration? retryTimeout;

  /// Force load image from remote source
  final bool forceRemoteSrc;

  /// Force load image from file source
  final bool forceFileSrc;

  /// Force load image from asset source
  final bool forceAssetSrc;

  /// Force load image from svg source
  final bool forceSvgSrc;

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
    this.onRetrySrc,
    this.maxRetryCount = 1,
    this.retryTimeout,
    this.forceFileSrc = false,
    this.forceRemoteSrc = false,
    this.forceAssetSrc = false,
    this.forceSvgSrc = false,
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
        onRetrySrc: onRetrySrc,
        maxRetryCount: maxRetryCount,
        timeoutRetry: retryTimeout,
        forceAssetSrc: forceAssetSrc,
        forceFileSrc: forceFileSrc,
        forceRemoteSrc: forceRemoteSrc,
        forceSvgSrc: forceSvgSrc,
      );
    } else {
      return placeholderWidget ??
          BaseImage(
            src: generateByName.isNotNullAndNotEmpty
                ? MediaHelper.generateAvatarByName(generateByName ?? 'user')
                : placeholderSrc ?? 'assets/images/img_not_found.png',
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
            onRetrySrc: onRetrySrc,
            maxRetryCount: maxRetryCount,
            timeoutRetry: retryTimeout,
            forceAssetSrc: forceAssetSrc,
            forceFileSrc: forceFileSrc,
            forceRemoteSrc: forceRemoteSrc,
            forceSvgSrc: forceSvgSrc,
          );
    }
  }
}

class BaseImage extends StatefulWidget {
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
  final Future<String?> Function()? onRetrySrc;
  final int maxRetryCount;
  final Duration? timeoutRetry;
  final bool forceRemoteSrc;
  final bool forceFileSrc;
  final bool forceAssetSrc;
  final bool forceSvgSrc;

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
    this.onRetrySrc,
    this.maxRetryCount = 1,
    this.timeoutRetry,
    this.forceFileSrc = false,
    this.forceRemoteSrc = false,
    this.forceAssetSrc = false,
    this.forceSvgSrc = false,
  });

  @override
  State<BaseImage> createState() => _BaseImageState();
}

class _BaseImageState extends State<BaseImage> {
  int retryCount = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.shapeImage == ShapeImage.circle) {
      assert(
        widget.size != null,
        "Size cannot be null if shapeImage is ShapeImage.circle, ",
      );
    }

    return GestureDetector(
      onTap: widget.enablePreview
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MediaPreviewPage(
                    src: widget.src,
                    isAsset: widget.isAsset,
                    title: widget.previewTitle,
                    titleStyle: widget.previewTitleStyle,
                    forceImage: true,
                  ),
                ),
              )
          : widget.onTapImage,
      child: _determineShapeImage(),
    );
  }

  Widget _determineShapeImage() {
    return switch (widget.shapeImage) {
      ShapeImage.oval => ClipOval(child: _determineImageWidget()),
      ShapeImage.circle => CircleAvatar(
          radius: widget.size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.size!),
            child: _determineImageWidget(),
          ),
        ),
      ShapeImage.react => ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
          child: _determineImageWidget(),
        ),
    };
  }

  Widget _determineImageWidget() {
    final isFromRemote = widget.src.startsWith('http');
    final isSvg = widget.src.endsWith('svg');
    final isAssets = widget.isAsset ||
        widget.src.startsWith('lib/resources/') ||
        widget.src.startsWith('assets/images/');
    final isFile = !isFromRemote && !isAssets && !isSvg;

    if (isSvg || widget.forceSvgSrc) {
      return SvgPicture.asset(
        widget.src,
        width: widget.width,
        height: widget.height,
        colorFilter: widget.color != null
            ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
            : null,
        fit: widget.fit,
        alignment: widget.alignment,
      );
    } else if (isFromRemote || widget.forceRemoteSrc) {
      return CachedNetworkImage(
        imageUrl: isFromRemote ? widget.src : 'https://${widget.src}',
        color: widget.color,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        alignment: widget.alignment,
        placeholder: (context, url) => SizedBox(
          height: widget.height,
          width: widget.width,
          child: widget.loadingWidget ?? const PlatformLoadingIndicator(),
        ),
        errorListener: (error) {
          debugPrint('Error load network image: $error');
        },
        errorWidget: (context, url, error) {
          debugPrint('Error load network image: $error');
          if (error.toString().contains('401') ||
              error.toString().contains('403')) {
            if (retryCount < widget.maxRetryCount &&
                widget.onRetrySrc != null) {
              widget.onRetrySrc!().then((value) {
                if (context.mounted) {
                  setState(() {
                    retryCount++;
                  });
                }
              });
            }
          }
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else if (isAssets || widget.forceAssetSrc) {
      return Image.asset(
        widget.src,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        color: widget.color,
        alignment: widget.alignment,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error load asset image $error');
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else if (isFile || widget.forceFileSrc) {
      return Image.file(
        File(widget.src),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        color: widget.color,
        alignment: widget.alignment,
        errorBuilder: (context, err, stackTrace) {
          debugPrint('Error load file image $err');
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else if (isFile || widget.forceFileSrc) {
      return Image.file(
        File(widget.src),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        color: widget.color,
        alignment: widget.alignment,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error load file image $error');
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.errorWidget ?? const Icon(Icons.error),
          );
        },
      );
    } else {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: widget.errorWidget ?? const Icon(Icons.error),
      );
    }
  }
}
