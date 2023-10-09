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
        username: 'nandakista',
      );
      emit(ProfileRepositoryLoaded(response));
    } catch (e) {
      emit(ProfileRepositoryError(e.toString()));
    }
  }
}
