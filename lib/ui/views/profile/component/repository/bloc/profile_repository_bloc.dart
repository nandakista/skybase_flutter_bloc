import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/blocs/base_hydrated_bloc.dart';
import 'package:skybase/config/blocs/bloc_extension.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'profile_repository_event.dart';

part 'profile_repository_state.dart';

class ProfileRepositoryBloc
    extends BaseHydratedBloc<Repo, ProfileRepositoryEvent, ProfileRepositoryState> {
  String tag = 'ProfileRepositoryBloc::->';

  final AuthRepository repository;

  ProfileRepositoryBloc(this.repository) : super(ProfileRepositoryInitial()) {
    on<LoadRepositories>(_onLoadData);

    loadData(
      () => addAndAwait(
        LoadRepositories(),
        (state) => state is ProfileRepositoryLoaded,
      ),
    );
  }

  @override
  ProfileRepositoryState? fromJson(Map<String, dynamic> json) {
    return ProfileRepositoryLoaded(loadCacheList(json));
  }

  @override
  Map<String, dynamic>? toJson(ProfileRepositoryState state) {
    return (state is ProfileRepositoryLoaded)
        ? saveCacheList(state.result)
        : null;
  }

  void _onLoadData(
    LoadRepositories event,
    Emitter<ProfileRepositoryState> emit,
  ) async {
    try {
      emit(ProfileRepositoryLoading());
      final response = await repository.getProfileRepository(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      emit(ProfileRepositoryLoaded(response));
    } catch (e) {
      emit(ProfileRepositoryError(e.toString()));
    }
  }
}
