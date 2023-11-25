import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

///  Default button on this project with primary color.
///  Change it as needed.
class SkyButton extends StatelessWidget {
  /// Background color of button. Default value is primary color.
  final Color color;

  /// Text color of button, default value is white.
  final Color? textColor;

  /// Text color of button, default value is white.
  final Color? borderColor;

  /// Text color of leading icon, default value is white.
  final Color? iconColor;

  /// Action or function that called when button pressed.
  final VoidCallback? onPressed;

  /// Display text in button.
  final String? text;

  /// Width shape of button
  final double? height;

  /// Width shape of button, default value is match parent.
  final double? width;

  final double? borderWidth;

  /// The size of text button.
  final double? fontSize;

  /// Border radius of the button
  final BorderRadiusGeometry? borderRadius;

  /// The radius of the button shape.
  final double radiusValue;

  /// Elevation value of button.
  final double? elevation;

  /// Leading icon inside button.
  final IconData? icon;

  /// Leading icon with Widget
  final Widget? leading;

  /// Font weight text and icon inside button.
  final FontWeight? fontWeight;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  /// Width of button
  final bool wrapContent;

  /// Change style button to outline mode
  final bool outlineMode;

  /// Widget inside the button
  final Widget? child;

  /// the option to change button color
  final Gradient? gradient;

  /// wether the button is can be clicked or not
  final bool enabled;

  const SkyButton({
    super.key,
    this.text,
    required this.onPressed,
    this.icon,
    this.color = AppColors.primary,
    this.iconColor,
    this.textColor,
    this.height = 48,
    this.width = double.infinity,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.padding,
    this.wrapContent = false,
    this.borderColor,
    this.borderWidth,
    this.leading,
    this.outlineMode = false,
    this.radiusValue = 8,
    this.child,
    this.gradient,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (wrapContent) ? null : width,
      height: (wrapContent) ? null : height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(radiusValue),
      ),
      child: ElevatedButton.icon(
        icon: Visibility(
          visible: (leading != null || icon != null),
          child: leading ??
              Icon(
                icon,
                color: iconColor ?? ((outlineMode) ? color : Colors.white),
              ),
        ),
        onPressed: (enabled) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: gradient != null
              ? Colors.transparent
              : (outlineMode)
                  ? Theme.of(context).scaffoldBackgroundColor
                  : color,
          padding: (icon != null || leading != null)
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
              : const EdgeInsets.fromLTRB(0, 10, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(radiusValue),
            side: BorderSide(
              color: enabled
                  ? (outlineMode)
                      ? borderColor ?? color
                      : borderColor ?? Colors.transparent
                  : Colors.transparent,
              width: borderWidth ?? 1.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        label: Container(
          padding: padding,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: child ??
                Text(
                  text ?? ' ',
                  textAlign: TextAlign.center,
                  style: AppStyle.subtitle4.copyWith(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: (!enabled)
                        ? Colors.grey.shade400
                        : textColor ?? (outlineMode ? color : textColor),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
