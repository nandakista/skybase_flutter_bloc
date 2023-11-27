import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/routes/app_routes.dart';

/// Base Class yang digunakan untuk navigation. Class ditujukan
/// untuk mempermudah jika ingin mengganti lib routing nya, sehingga hanya perlu
/// diubah di class ini saja
class Navigation {
  static Navigation get instance => sl<Navigation>();

  void push<T extends Object?>(
    BuildContext context,
    String path, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    context.pushNamed(
      path,
      extra: arguments,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  void pushReplacement<T extends Object?>(
    BuildContext context,
    String path, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    context.pushReplacementNamed(
      path,
      extra: arguments,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  void pop<T extends Object?>(BuildContext context, {int? times, T? result}) {
    if (context.canPop()) context.pop(result);

    if (times != null && times >= 1) {
      for (int i = 1; i < times; i++) {
        if (context.canPop()) context.pop();
      }
    }
  }

  /// Menghapus semua route dibelakangnya dan melakukan pushReplacement untuk
  /// route tujuan.
  void pushAllReplacement<T extends Object?>(
    BuildContext context,
    String path, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(
      path,
      extra: arguments,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  /// Menghapus semua route dibelakangnya sampai [predicatePath] dan melakukan
  /// push route [path] sehingga current route menjadi -> {predicate, path}
  void popUntilAndPush(
    BuildContext context,
    String path,
    String predicatePath, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    while (context.canPop() &&
        ModalRoute.of(context)?.settings.name != predicatePath) {
      context.pop();
    }
    context.pushNamed(
      path,
      extra: arguments,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }

  /// Melakukan back/pop sampai target [path]. Similar seperti Get.until()
  void popUntil(
    BuildContext context,
    String path, {
    Object? arguments,
  }) {
    while (context.canPop() && ModalRoute.of(context)?.settings.name != path) {
      context.pop(arguments);
    }
  }

  void pushAllReplacementNoContext<T extends Object?>(
    String path, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    AppRoutes.router.goNamed(path, extra: arguments);
  }

  void popNoContext<T extends Object?>([T? arguments]) {
    AppRoutes.router.pop(arguments);
  }

  ///
  /// Menuju path dan menghapus semua stack dibelakangnya.
  /// Jika path tujuan ada di stack maka tidak akan di refresh, jike
  /// path tujuan tidak ada di stack maka akan menjadi route baru (push).
  ///
  /// **Note:**
  /// Only available in GoRouter.
  void go(
    BuildContext context,
    String path, {
    Object? arguments,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    context.goNamed(
      path,
      extra: arguments,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }
}
