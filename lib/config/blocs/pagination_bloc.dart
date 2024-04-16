import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/base/pagination_mixin.dart';
import 'package:skybase/config/blocs/bloc_extension.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';

abstract class PaginationBloc<T, E, S> extends HydratedBloc<E, S>
    with PaginationMixin<T> {
  final String _tag = 'PaginationBloc::->';

  CancelToken cancelToken = CancelToken();

  PaginationBloc(super.state);

  List<T>? _tempData = [];

  /// Must be call this in init state for make pagination not loading
  void loadPagingData({
    required E event,
    required bool Function(S state) state,
    required bool until,
  }) {
    if (until) {
      pagingController.value = PagingState(
        nextPageKey: page,
        error: null,
        itemList: _tempData,
      );
    }
    try {
      loadData(() => addAndAwait(event, state));
    } catch (e) {
      log('$_tag Failed to load paging data');
    }
  }

  /// Hydrated Bloc helper for saving data into cache
  /// only save page 1 for caching
  /// Should called in toJson hydrated
  Map<String, dynamic>? saveCache(List<T> data) {
    try {
      if (page == 1) {
        _tempData = data;
        return {
          'data': List.from(
            data.map((x) => CachedModelConverter<T>().toJson(x)),
          ),
        };
      } else {
        _tempData?.clear();
        return null;
      }
    } catch (e, stack) {
      log('$_tag Error save cache, error = $e, $stack');
      return null;
    }
  }

  /// Hydrated Bloc helper for get cache
  /// should called in fromJson hydrated
  List<T> loadCache(Map<String, dynamic> json) {
    try {
      return ((json['data'] as List?) ?? [])
          .map((e) => CachedModelConverter<T>().fromJson(e))
          .toList();
    } catch (e, stack) {
      log('$_tag Error load cache, error = $e, $stack');
      return [];
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    cancelToken.cancel();
    return super.close();
  }
}
