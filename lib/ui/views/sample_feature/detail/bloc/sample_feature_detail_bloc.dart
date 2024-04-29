import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/config/blocs/base_hydrated_bloc.dart';
import 'package:skybase/config/blocs/bloc_extension.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_detail_event.dart';

part 'sample_feature_detail_state.dart';

class SampleFeatureDetailBloc extends BaseHydratedBloc<SampleFeature,
    SampleFeatureDetailEvent, SampleFeatureDetailState> {
  String tag = 'SampleFeatureDetailBloc::->';

  final SampleFeatureRepository repository;
  final int userId;
  final String username;

  @override
  String get id => userId.toString();

  SampleFeatureDetailBloc({
    required this.repository,
    required this.userId,
    required this.username,
  }) : super(SampleFeatureDetailInitial()) {
    on<LoadGithubUser>(_onLoadData);

    loadData(
      () => addAndAwait(
        LoadGithubUser(userId, username),
        (state) => state is SampleFeatureDetailLoaded,
      ),
    );
  }

  @override
  SampleFeatureDetailState? fromJson(Map<String, dynamic> json) {
    return SampleFeatureDetailLoaded(loadCache(json));
  }

  @override
  Map<String, dynamic>? toJson(SampleFeatureDetailState state) {
    return (state is SampleFeatureDetailLoaded)
        ? saveCache(state.result)
        : null;
  }

  Future<void> _onLoadData(
    LoadGithubUser event,
    Emitter<SampleFeatureDetailState> emit,
  ) async {
    try {
      if (state is SampleFeatureDetailInitial) emit(SampleFeatureDetailLoading());
      final response = await repository.getDetailUser(
        cancelToken: cancelToken,
        id: event.id,
        username: event.username,
      );
      emit(SampleFeatureDetailLoaded(response));
    } catch (e) {
      emit(SampleFeatureDetailError(e.toString()));
    }
  }
}
