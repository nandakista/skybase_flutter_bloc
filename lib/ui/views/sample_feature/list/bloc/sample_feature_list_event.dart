part of 'sample_feature_list_bloc.dart';

sealed class SampleFeatureListEvent extends Equatable {
  const SampleFeatureListEvent();

  @override
  List<Object> get props => [];
}

class LoadGithubUsers extends SampleFeatureListEvent {
  const LoadGithubUsers(this.username);

  final String username;

  @override
  List<Object> get props => [];
}
