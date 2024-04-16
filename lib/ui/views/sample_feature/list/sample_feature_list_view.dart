import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/widgets/base/pagination_state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureListView extends StatefulWidget {
  static const String route = '/user-list';

  const SampleFeatureListView({super.key});

  @override
  State<SampleFeatureListView> createState() => _SampleFeatureListViewState();
}

class _SampleFeatureListViewState extends State<SampleFeatureListView>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'txt_list_users'.tr()),
      body: BlocConsumer<SampleFeatureListBloc, SampleFeatureListState>(
        listener: (BuildContext context, SampleFeatureListState state) {
          SampleFeatureListBloc bloc = context.read<SampleFeatureListBloc>();
          if (state is SampleFeatureListError) {
            bloc.loadError(state.message);
          } else if (state is SampleFeatureListLoaded) {
            bloc.loadNextData(data: state.result);
          }
        },
        builder: (context, state) {
          SampleFeatureListBloc bloc = context.read<SampleFeatureListBloc>();
          return PaginationStateView<SampleFeature>.list(
            pagingController: bloc.pagingController,
            loadingView: const ShimmerSampleFeatureList(),
            onRefresh: bloc.onRefresh,
            onRetry: bloc.onRefresh,
            itemBuilder: (BuildContext context, item, int index) {
              return ListTile(
                onTap: () {
                  Navigation.instance.push(
                    context,
                    SampleFeatureDetailView.route,
                    arguments: {
                      'id': item.id,
                      'username': item.username,
                    },
                  );
                },
                leading: SkyImage(
                  shapeImage: ShapeImage.circle,
                  size: 30,
                  src: '${item.avatarUrl}&s=200',
                ),
                title: Text(item.username.toString()),
                subtitle: Text(
                  item.gitUrl.toString(),
                  style: AppStyle.body2,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          LoadingDialog.show(context);
          await HydratedBloc.storage.clear();
          if (context.mounted) LoadingDialog.dismiss(context);
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
