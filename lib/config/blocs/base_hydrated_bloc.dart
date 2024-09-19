import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/config/blocs/hydrated_cache_mixin.dart';

/// Base bloc with several generic type, each description of type explained below :
/// - T is type data
/// - E is event bloc
/// - S is state bloc
abstract class BaseHydratedBloc<T, E, S> extends HydratedBloc<E, S>
    with HydratedCacheMixin<T> {
  CancelToken cancelToken = CancelToken();

  BaseHydratedBloc(super.state);

  Future Function()? _onLoad;

  bool get keepAlive => false;

  void emitLoading(Emitter<S> emit, S state, {bool? when}) async {
    dynamic cachedData = await HydratedBloc.storage.read(storageToken);
    if (when == true && cachedData == null) {
      emit(state);
    } else {
      if (!keepAlive && cachedData == null) {
        emit(state);
      }
    }
  }

  void loadData({required Future Function() onLoad}) async {
    this._onLoad = onLoad;
    await onLoad();
  }

  Future<void> onRefresh([BuildContext? context]) async {
    if (_onLoad != null) {
      await clear();
      await _onLoad!();
    }
  }

  void onClose() {}

  @override
  @protected
  @mustCallSuper
  Future<void> close() {
    cancelToken.cancel();
    onClose();
    return super.close();
  }
}
