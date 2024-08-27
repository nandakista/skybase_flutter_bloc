import 'package:flutter/material.dart';
import 'package:skybase/config/environment/app_env.dart';

class EnvBanner extends StatelessWidget {
  final Widget child;
  final String title;
  final Color color;

  const EnvBanner({
    super.key,
    required this.child,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (AppEnv.env.isProduction) return child;

    return Stack(
      children: <Widget>[
        child,
        _buildBanner(context),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: CustomPaint(
        painter: BannerPainter(
          message: title,
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topEnd,
          color: color,
        ),
      ),
    );
  }
}
