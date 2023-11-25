import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skybase/config/themes/app_colors.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

/// Wrap your Scaffold to this widget for set Status Bar color in specific pages.
/// the default factory is light
class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    super.key,
    required this.child,
    this.color,
    this.brightness = Brightness.light,
    this.coloredBottomBar = false,
  });

  factory ColoredStatusBar.light({
    required Widget child,
    Color? color,
    bool coloredBottomBar = false,
  }) =>
      ColoredStatusBar(
        color: color,
        brightness: Brightness.light,
        coloredBottomBar: coloredBottomBar,
        child: child,
      );

  factory ColoredStatusBar.dark({
    required Widget child,
    Color color = Colors.black,
    bool coloredBottomBar = false,
  }) =>
      ColoredStatusBar(
        color: color,
        brightness: Brightness.dark,
        coloredBottomBar: coloredBottomBar,
        child: child,
      );

  factory ColoredStatusBar.primary({
    required Widget child,
    Color color = AppColors.primary,
    bool coloredBottomBar = false,
    Brightness brightness = Brightness.dark,
  }) =>
      ColoredStatusBar(
        color: color,
        brightness: brightness,
        coloredBottomBar: coloredBottomBar,
        child: child,
      );

  /// Background color of Status Bar
  final Color? color;

  /// Icon Color in Status Bar.
  ///
  /// Brightness.dark == Icon White.
  ///
  /// Brightness.light == Icon Black
  final Brightness brightness;

  /// Color of bottom bar (under navigation bar).
  final bool coloredBottomBar;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final androidIconBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: androidIconBrightness,
        statusBarBrightness: brightness,
      ),
      child: Container(
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          left: false,
          right: false,
          bottom: coloredBottomBar,
          child: child,
        ),
      ),
    );
  }
}
