import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

part 'sample_feature_detail_event.dart';

part 'sample_feature_detail_state.dart';

class SampleFeatureDetailBloc
    extends Bloc<SampleFeatureDetailEvent, SampleFeatureDetailState> {
  String tag = 'SampleFeatureDetailBloc::->';

  final SampleFeatureRepository repository;
  CancelToken cancelToken = CancelToken();

  SampleFeatureDetailBloc(this.repository)
      : super(SampleFeatureDetailInitial()) {
    on<LoadGithubUser>(_onLoadData);
    on<RefreshGithubUser>(_onRefreshData);
  }

  Future<void> _onRefreshData(
    RefreshGithubUser event,
    Emitter<SampleFeatureDetailState> emit,
  ) async {
    await StorageManager.instance
        .delete('${CachedKey.SAMPLE_FEATURE_DETAIL}/${event.id}');
    await _onLoadData(LoadGithubUser(event.id, event.username), emit);
  }

  Future<void> _onLoadData(
    LoadGithubUser event,
    Emitter<SampleFeatureDetailState> emit,
  ) async {
    try {
      emit(SampleFeatureDetailLoading());
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
