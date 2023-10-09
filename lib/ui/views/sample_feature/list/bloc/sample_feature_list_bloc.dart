import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';

part 'sample_feature_list_event.dart';

part 'sample_feature_list_state.dart';

class SampleFeatureListBloc
    extends Bloc<SampleFeatureListEvent, SampleFeatureListState> {
  String tag = 'SampleFeatureListBloc::->';

  final SampleFeatureRepository repository;

  SampleFeatureListBloc(this.repository) : super(SampleFeatureListInitial()) {
    on<LoadGithubUsers>(_onLoadData);
  }

  void _onLoadData(
    LoadGithubUsers event,
    Emitter<SampleFeatureListState> emit,
  ) async {
    try {
      emit(SampleFeatureListLoading());
      final response = await repository.getUsers(
        page: event.page,
        perPage: event.perPage,
      );
      emit(SampleFeatureListLoaded(response));
    } catch (e) {
      emit(SampleFeatureListError(e.toString()));
    }
  }
}
