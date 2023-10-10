import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final String tag = 'AppBlocObserver::->';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate() -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    final blocType = bloc.runtimeType;
    final changeType = change.runtimeType;

    log('$tag onChange() -- {blocType:$blocType, changeType:$changeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('$tag onEvent() -- an event Happened in $bloc the event is $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('$tag onClose() -- ${bloc.runtimeType}');
  }
}
