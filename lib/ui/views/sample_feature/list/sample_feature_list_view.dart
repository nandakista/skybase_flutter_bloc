import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/base/pagination_mixin.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';
import 'package:skybase/ui/widgets/sky_view.dart';

class SampleFeatureListView extends StatefulWidget {
  static const String route = '/user-list';

  const SampleFeatureListView({super.key});

  @override
  State<SampleFeatureListView> createState() => _SampleFeatureListViewState();
}

class _SampleFeatureListViewState extends State<SampleFeatureListView>
    with PaginationMixin<SampleFeature>, AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    loadData(
      () => context
          .read<SampleFeatureListBloc>()
          .add(LoadGithubUsers(page, perPage)),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> onRefresh() {
    deleteCached(CachedKey.SAMPLE_FEATURE_LIST);
    return super.onRefresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'txt_list_users'.tr()),
      body: BlocConsumer<SampleFeatureListBloc, SampleFeatureListState>(
        listener: (BuildContext context, SampleFeatureListState state) {
          if (state is SampleFeatureListError) {
            showError(state.message);
          } else if (state is SampleFeatureListLoaded) {
            finishLoadData(data: state.result);
          }
        },
        builder: (context, state) {
          return SkyView.pagination<SampleFeature>(
            pagingController: pagingController,
            loadingView: const ShimmerList(),
            onRefresh: onRefresh,
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
          await StorageManager.instance.delete(CachedKey.SAMPLE_FEATURE_LIST);
          await StorageManager.instance.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
          if (context.mounted) LoadingDialog.dismiss(context);
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
