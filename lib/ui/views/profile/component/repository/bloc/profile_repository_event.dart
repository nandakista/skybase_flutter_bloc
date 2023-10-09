part of 'profile_repository_bloc.dart';

sealed class ProfileRepositoryEvent extends Equatable {
  const ProfileRepositoryEvent();

  @override
  List<Object> get props => [];
}

class LoadRepositories extends ProfileRepositoryEvent {}
