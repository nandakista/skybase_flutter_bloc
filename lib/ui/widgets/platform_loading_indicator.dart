import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformLoadingIndicator extends StatelessWidget {
  const PlatformLoadingIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    } else {
      return Center(
        child: CupertinoActivityIndicator(
          radius: 16,
          color: color,
        ),
      );
    }
  }
}
