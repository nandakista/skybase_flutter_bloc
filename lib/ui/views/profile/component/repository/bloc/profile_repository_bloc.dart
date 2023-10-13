import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'profile_repository_event.dart';

part 'profile_repository_state.dart';

class ProfileRepositoryBloc
    extends Bloc<ProfileRepositoryEvent, ProfileRepositoryState> {
  String tag = 'ProfileRepositoryBloc::->';

  final AuthRepository repository;
  CancelToken cancelToken = CancelToken();

  ProfileRepositoryBloc(this.repository) : super(ProfileRepositoryInitial()) {
    on<LoadRepositories>(_onLoadData);
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

  @override
  Future<void> close() {
    cancelToken.cancel();
    return super.close();
  }
}
