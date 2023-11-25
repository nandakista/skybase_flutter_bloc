import 'package:flutter/material.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    this.title,
    this.action,
    this.backgroundColor,
    this.centerTitle = false,
    this.titleStyle,
    this.iconColor,
    this.elevation,
    this.height,
    this.iconSize,
  });

  final String? title;
  final Color? backgroundColor;
  final List<Widget>? action;
  final bool? centerTitle;
  final Color? iconColor;
  final TextStyle? titleStyle;
  final double? elevation;
  final double? height;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title ?? '',
        style: titleStyle,
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
      actions: action,
      iconTheme: IconThemeData(color: iconColor, size: iconSize),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
