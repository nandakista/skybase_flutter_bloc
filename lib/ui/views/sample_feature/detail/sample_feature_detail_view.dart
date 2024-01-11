import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/sky_view.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends StatefulWidget {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({
    super.key,
    required this.idArgs,
    required this.usernameArgs,
  });

  final int idArgs;
  final String usernameArgs;

  @override
  State<SampleFeatureDetailView> createState() =>
      _SampleFeatureDetailViewState();
}

class _SampleFeatureDetailViewState extends State<SampleFeatureDetailView> {
  @override
  void initState() {
    Future.microtask(
      () => context
          .read<SampleFeatureDetailBloc>()
          .add(LoadGithubUser(widget.idArgs, widget.usernameArgs)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: widget.usernameArgs),
      body: SafeArea(
        child: BlocBuilder<SampleFeatureDetailBloc, SampleFeatureDetailState>(
          builder: (context, state) {
            final bloc = context.read<SampleFeatureDetailBloc>();
            final data =
                (state is SampleFeatureDetailLoaded) ? state.result : null;
            final errMessage =
                (state is SampleFeatureDetailError) ? state.message : null;

            return SkyView.page(
              loadingEnabled: state is SampleFeatureDetailLoading,
              errorEnabled: state is SampleFeatureDetailError,
              emptyEnabled: false,
              loadingView: const ShimmerDetail(),
              errorTitle: errMessage,
              onRefresh: () => bloc
                  .add(RefreshGithubUser(widget.idArgs, widget.usernameArgs)),
              onRetry: () => bloc
                  .add(RefreshGithubUser(widget.idArgs, widget.usernameArgs)),
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
