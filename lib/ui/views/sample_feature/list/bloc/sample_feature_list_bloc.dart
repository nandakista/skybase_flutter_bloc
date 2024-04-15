import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_list_event.dart';

part 'sample_feature_list_state.dart';

class SampleFeatureListBloc
    extends HydratedBloc<SampleFeatureListEvent, SampleFeatureListState> {
  String tag = 'SampleFeatureListBloc::->';

  final SampleFeatureRepository repository;
  CancelToken cancelToken = CancelToken();

  SampleFeatureListBloc(this.repository) : super(SampleFeatureListInitial()) {
    on<LoadGithubUsers>(_onLoadData);
  }

  @override
  SampleFeatureListState? fromJson(Map<String, dynamic> json) {
    return SampleFeatureListLoaded(((json['data'] as List?) ?? [])
        .map((e) => SampleFeature.fromJson(e as Map<String, dynamic>))
        .toList());
  }

  @override
  Map<String, dynamic>? toJson(SampleFeatureListState state) {
    return (state is SampleFeatureListLoaded)
        ? {
            'data': List<dynamic>.from(state.result.map((x) => x.toJson())),
          }
        : null;
  }

  void _onLoadData(
    LoadGithubUsers event,
    Emitter<SampleFeatureListState> emit,
  ) async {
    try {
      emit(SampleFeatureListLoading());
      final response = await repository.getUsers(
        cancelToken: cancelToken,
        page: event.page,
        perPage: event.perPage,
      );
      emit(SampleFeatureListLoaded(response));
    } catch (e) {
      emit(SampleFeatureListError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    cancelToken.cancel();
    return super.close();
  }
}
