part of 'sample_feature_list_bloc.dart';

sealed class SampleFeatureListEvent extends Equatable {
  const SampleFeatureListEvent();

  @override
  List<Object> get props => [];
}

class LoadGithubUsers extends SampleFeatureListEvent {
  final int page;
  final int perPage;

  const LoadGithubUsers(this.page, this.perPage);

  @override
  List<Object> get props => [page, perPage];
}
