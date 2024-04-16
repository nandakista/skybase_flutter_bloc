import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';

abstract class BaseBloc<T, E, S> extends HydratedBloc<E, S> {
  final String _tag = 'BaseBloc::->';

  CancelToken cancelToken = CancelToken();

  BaseBloc(super.state);

  Future Function()? _onLoad;

  void loadData(Future Function() onLoad) async {
    await onLoad();
    this._onLoad = onLoad;
  }

  void onRefresh() async {
    if (_onLoad != null) {
      await clear();
      await _onLoad!();
    }
  }

  /// Hydrated Bloc helper for saving data into cache
  /// only save page 1 for caching
  /// Should called in toJson hydrated
  Map<String, dynamic>? saveCache(T data) {
    try {
      return CachedModelConverter<T>().toJson(data);
    } catch (e, stack) {
      log('$_tag Error save cache, error = $e, $stack');
      return null;
    }
  }

  /// Hydrated Bloc helper for get cache
  /// should called in fromJson hydrated
  T loadCache(Map<String, dynamic> json) {
    try {
      return CachedModelConverter<T>().fromJson(json);
    } catch (e, stack) {
      log('$_tag Error load cache, error = $e, $stack');
      throw Exception('$_tag Failed when load cache');
    }
  }

  @override
  Future<void> close() {
    cancelToken.cancel();
    return super.close();
  }
}