import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/config/blocs/pagination_hydrated_bloc.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/config/blocs/bloc_extension.dart';

part 'sample_feature_list_event.dart';

part 'sample_feature_list_state.dart';

class SampleFeatureListBloc extends PaginationHydratedBloc<SampleFeature,
    SampleFeatureListEvent, SampleFeatureListState> {
  String tag = 'SampleFeatureListBloc::->';

  final SampleFeatureRepository repository;

  String? querySearch;

  @override
  bool get keepAlive => false;

  SampleFeatureListBloc(this.repository) : super(SampleFeatureListInitial()) {
    on<LoadGithubUsers>(_onLoadData);
    on<SearchUser>(_onSearchData);

    loadPagingData(
      onLoad:
          () => addAndAwait(
            const LoadGithubUsers(),
            (state) => state is SampleFeatureListLoaded,
          ),
      until: state is SampleFeatureListLoaded,
    );
  }

  @override
  SampleFeatureListState? fromJson(Map<String, dynamic> json) {
    return SampleFeatureListLoaded(loadCacheList(json));
  }

  @override
  Map<String, dynamic>? toJson(SampleFeatureListState state) {
    return (state is SampleFeatureListLoaded && querySearch == null)
        ? saveCacheList(state.result)
        : null;
  }

  void _onLoadData(
    LoadGithubUsers event,
    Emitter<SampleFeatureListState> emit,
  ) async {
    try {
      emitLoading(emit, SampleFeatureListLoading());
      final response = await repository.getUsers(
        cancelToken: cancelToken,
        page: page,
        perPage: perPage,
        username: querySearch,
      );
      emit(SampleFeatureListLoaded(response));
    } catch (e) {
      emit(SampleFeatureListError(e.toString()));
    }
  }

  void _onSearchData(
    SearchUser event,
    Emitter<SampleFeatureListState> emit,
  ) async {
    querySearch = event.querySearch;
    resetState();
    add(LoadGithubUsers());
  }
}
