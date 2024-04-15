import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_detail_event.dart';

part 'sample_feature_detail_state.dart';

class SampleFeatureDetailBloc
    extends HydratedBloc<SampleFeatureDetailEvent, SampleFeatureDetailState> {
  String tag = 'SampleFeatureDetailBloc::->';

  final SampleFeatureRepository repository;
  final int userId;

  CancelToken cancelToken = CancelToken();

  @override
  String get id => userId.toString();

  @override
  SampleFeatureDetailState? fromJson(Map<String, dynamic> json) {
    return SampleFeatureDetailLoaded(SampleFeature.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(SampleFeatureDetailState state) {
    return (state is SampleFeatureDetailLoaded) ? state.result.toJson() : null;
  }

  SampleFeatureDetailBloc({required this.repository, required this.userId})
      : super(SampleFeatureDetailInitial()) {
    on<LoadGithubUser>(_onLoadData);
    on<RefreshGithubUser>(_onRefreshData);
  }

  Future<void> _onRefreshData(
    RefreshGithubUser event,
    Emitter<SampleFeatureDetailState> emit,
  ) async {
    await clear();
    emit(SampleFeatureDetailLoading());
    await _onLoadData(LoadGithubUser(event.id, event.username), emit);
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

  @override
  Future<void> close() {
    cancelToken.cancel();
    return super.close();
  }
}
