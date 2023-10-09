import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/base/pagination_mixin.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/core/base/main_navigation.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/widgets/base/sky_pagination_view.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureListView extends StatefulWidget {
  static const String route = '/user-list';

  const SampleFeatureListView({Key? key}) : super(key: key);

  @override
  State<SampleFeatureListView> createState() => _SampleFeatureListViewState();
}

class _SampleFeatureListViewState extends State<SampleFeatureListView>
    with PaginationMixin<SampleFeature> {

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
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'txt_list_users'),
      body: BlocConsumer<SampleFeatureListBloc, SampleFeatureListState>(
        listener: (BuildContext context, SampleFeatureListState state) {
          if (state is SampleFeatureListError) {
            showError(state.message);
          } else if (state is SampleFeatureListLoaded) {
            finishLoadData(data: state.result);
          }
        },
        builder: (context, state) {
          return SkyPaginationView<SampleFeature>(
            pagingController: pagingController,
            onRefresh: onRefresh,
            itemBuilder: (BuildContext context, item, int index) {
              return ListTile(
                onTap: () {
                  MainNavigation.push(
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
        onPressed: () {
          StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_LIST);
          StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
