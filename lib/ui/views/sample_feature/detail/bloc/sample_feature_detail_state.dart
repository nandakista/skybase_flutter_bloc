part of 'sample_feature_detail_bloc.dart';

@immutable
sealed class SampleFeatureDetailState extends Equatable {
  const SampleFeatureDetailState();

  @override
  List<Object?> get props => [];
}

class SampleFeatureDetailInitial extends SampleFeatureDetailState {}

class SampleFeatureDetailLoading extends SampleFeatureDetailState {}

class SampleFeatureDetailError extends SampleFeatureDetailState {
  final String message;

  const SampleFeatureDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SampleFeatureDetailLoaded extends SampleFeatureDetailState {
  final SampleFeature result;

  const SampleFeatureDetailLoaded(this.result);

  @override
  List<Object> get props => [result];
}
