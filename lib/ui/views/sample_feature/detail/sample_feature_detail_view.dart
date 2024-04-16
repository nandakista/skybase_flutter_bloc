import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends StatelessWidget {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: username),
      body: SafeArea(
        child: BlocBuilder<SampleFeatureDetailBloc, SampleFeatureDetailState>(
          builder: (context, state) {
            final bloc = context.read<SampleFeatureDetailBloc>();
            final data =
                (state is SampleFeatureDetailLoaded) ? state.result : null;
            final errMessage =
                (state is SampleFeatureDetailError) ? state.message : null;

            return StateView.page(
              loadingEnabled: state is SampleFeatureDetailLoading,
              errorEnabled: state is SampleFeatureDetailError,
              emptyEnabled: false,
              loadingView: const ShimmerSampleFeatureDetail(),
              errorTitle: errMessage,
              onRefresh: bloc.onRefresh,
              onRetry: bloc.onRefresh,
              child: Column(
                children: [
                  SampleFeatureDetailHeader(
                    avatar: data?.avatarUrl ?? '',
                    repositoryCount: data?.repository ?? 0,
                    followerCount: data?.followers ?? 0,
                    followingCount: data?.following ?? 0,
                  ),
                  SampleFeatureDetailInfo(
                    name: data?.name ?? '',
                    bio: data?.bio ?? '',
                    company: data?.company ?? '',
                    location: data?.location ?? '',
                  ),
                  SampleFeatureDetailTab(data: data),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
