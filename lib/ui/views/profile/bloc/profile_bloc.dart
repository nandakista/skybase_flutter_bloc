import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/blocs/base_hydrated_bloc.dart';
import 'package:skybase/config/blocs/bloc_extension.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends BaseHydratedBloc<User, ProfileEvent, ProfileState> {
  String tag = 'ProfileBloc::->';

  final AuthRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadData);
    loadData(
      onLoad: () => addAndAwait(
        LoadProfile(),
        (state) => state is ProfileLoaded,
      ),
    );
  }

  @override
  bool get keepAlive => true;

  @override
  fromJson(Map<String, dynamic> json) {
    return ProfileLoaded(loadCache(json));
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return (state is ProfileLoaded) ? saveCache(state.result) : null;
  }

  @override
  Future<void> onRefresh([BuildContext? context]) async {
    super.onRefresh();
    await context?.read<ProfileRepositoryBloc>().onRefresh();
  }

  Future<void> _onLoadData(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emitLoading(emit, ProfileLoading(), when: state is ProfileInitial);
      final response = await repository.getProfile(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      emit(ProfileLoaded(response));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
