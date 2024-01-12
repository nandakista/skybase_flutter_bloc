import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

final sampleFeatureDetailPage = [
  GoRoute(
    path: SampleFeatureDetailView.route,
    name: SampleFeatureDetailView.route,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      return BlocProvider(
        create: (_) => sl<SampleFeatureDetailBloc>(),
        child: SampleFeatureDetailView(
          idArgs: extra['id'] as int,
          usernameArgs: extra['username'] as String,
        ),
      );
    },
  ),
];
