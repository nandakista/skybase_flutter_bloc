part of 'profile_repository_bloc.dart';

@immutable
sealed class ProfileRepositoryState extends Equatable {
  const ProfileRepositoryState();

  @override
  List<Object?> get props => [];
}

class ProfileRepositoryInitial extends ProfileRepositoryState {}

class ProfileRepositoryLoading extends ProfileRepositoryState {}

class ProfileRepositoryError extends ProfileRepositoryState {
  final String message;

  const ProfileRepositoryError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileRepositoryLoaded extends ProfileRepositoryState {
  final List<Repo> result;

  const ProfileRepositoryLoaded(this.result);

  @override
  List<Object> get props => [result];
}
