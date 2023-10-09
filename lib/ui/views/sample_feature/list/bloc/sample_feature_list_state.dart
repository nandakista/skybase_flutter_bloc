part of 'sample_feature_list_bloc.dart';

@immutable
sealed class SampleFeatureListState extends Equatable {
  const SampleFeatureListState();

  @override
  List<Object?> get props => [];
}

class SampleFeatureListInitial extends SampleFeatureListState {}

class SampleFeatureListLoading extends SampleFeatureListState {}

class SampleFeatureListError extends SampleFeatureListState {
  final String message;

  const SampleFeatureListError(this.message);

  @override
  List<Object> get props => [message];
}

class SampleFeatureListLoaded extends SampleFeatureListState {
  final List<SampleFeature> result;

  const SampleFeatureListLoaded(this.result);

  @override
  List<Object> get props => [result];
}
