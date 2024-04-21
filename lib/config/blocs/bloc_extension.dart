import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension<Event, State> on Bloc<Event, State> {
  /// Add bloc event and wait until predicate returns true
  Future<void> addAndAwait(
    Event event,
    bool Function(State state) predicate,
  ) async {
    add(event);
    await stream.firstWhere(predicate);
  }
}
