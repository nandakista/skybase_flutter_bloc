part of 'sample_feature_detail_bloc.dart';

sealed class SampleFeatureDetailEvent extends Equatable {
  const SampleFeatureDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadGithubUser extends SampleFeatureDetailEvent {
  final int id;
  final String username;

  const LoadGithubUser(this.id, this.username);

  @override
  List<Object> get props => [id, username];
}

class RefreshGithubUser extends SampleFeatureDetailEvent {
  final int id;
  final String username;

  const RefreshGithubUser(this.id, this.username);

  @override
  List<Object> get props => [id, username];
}
