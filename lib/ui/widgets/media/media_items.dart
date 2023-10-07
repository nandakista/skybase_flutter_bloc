import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/media/preview/media_list_preview_page.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class MediaItems extends StatelessWidget {
  final VoidCallback? onTapMore;
  final void Function(int)? onTap;
  final List<String> mediaUrls;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final int maxItem;
  final bool isGrid;
  final double size;
  final double itemsSpacing;
  final String? moreText;
  final double borderRadius;

  const MediaItems({
    Key? key,
    required this.mediaUrls,
    this.onTapMore,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.onTap,
    this.isGrid = false,
    this.size = 56.0,
    this.maxItem = 4,
    this.itemsSpacing = 5,
    this.moreText,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemSize = size;
    if (mediaUrls.length == 1) {
      itemSize = size * 2 + itemsSpacing;
    }

    double containerSize = size + itemsSpacing + size; // 2 rows
    if (mediaUrls.length == 1) {
      containerSize = itemSize;
    }

    final List<Widget> items = [];
    for (var i = 0; i < min(maxItem, mediaUrls.length); i++) {
      if (mediaUrls.length > maxItem && i >= maxItem - 1) {
        items.add(
          GestureDetector(
            onTap: onTapMore ??
                () {
                  Get.to(
                    () => MediaListPreviewPage(
                      mediaUrls: mediaUrls,
                    ),
                  );
                },
            child: SizedBox(
              width: itemSize,
              height: itemSize,
              child: _MoreItem(
                text: moreText ?? "+ ${mediaUrls.length - maxItem}",
                isGrid: isGrid,
                child: _determineMedia(mediaUrls[i], i),
              ),
            ),
          ),
        );
      } else {
        items.add(
          SizedBox(
            width: itemSize,
            height: itemSize,
            child: _determineMedia(mediaUrls[i], i),
          ),
        );
      }
    }

    return (isGrid)
        ? Row(
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Container(
                width: containerSize,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: itemsSpacing,
                  runSpacing: itemsSpacing,
                  children: items,
                ),
              ),
            ],
          )
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: itemsSpacing,
            runSpacing: itemsSpacing,
            children: items,
          );
  }

  Widget _determineMedia(String path, int index) {
    final mediaType = MediaHelper.getMediaType(path);
    switch (mediaType.type) {
      case MediaType.FILE:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.IMAGE:
        return SkyImage(
          src: mediaType.path,
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.circular((isGrid) ? 0 : borderRadius),
          onTap: (onTap != null)
              ? () {
                  onTap!(index);
                }
              : null,
          enablePreview: onTap == null,
          fit: BoxFit.cover,
        );
      case MediaType.VIDEO:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.UNKNOWN:
        return const Center(child: Text('Media Unsupported'));
    }
  }
}

class _MoreItem extends StatelessWidget {
  final String text;
  final Widget child;
  final bool isGrid;

  const _MoreItem({
    Key? key,
    required this.child,
    required this.text,
    required this.isGrid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular((isGrid) ? 0 : 8),
            ),
            child: Center(
              child: Text(text, style: _moreStyle),
            ),
          ),
        ),
      ],
    );
  }
}

const _moreStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
