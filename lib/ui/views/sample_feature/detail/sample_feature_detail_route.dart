import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

final sampleFeatureDetailPage = [
  GoRoute(
    path: SampleFeatureDetailView.route,
    name: SampleFeatureDetailView.route,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      return SampleFeatureDetailView(
        idArgs: extra['id'] as int,
        usernameArgs: extra['username'] as String,
      );
    },
  ),
];
