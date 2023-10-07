import 'dart:async';

import 'package:flutter/foundation.dart';

/// Converts a [Stream] into a [Listenable]
///
/// {@tool snippet}
/// Typical usage is as follows:
///
/// ```dart
/// StreamListener(stream)
/// ```
/// {@end-tool}
class StreamListener extends ChangeNotifier {
  /// Creates a [StreamListener].
  ///
  /// Every time the [Stream] receives an event this [ChangeNotifier] will
  /// notify its listeners.
  StreamListener(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}