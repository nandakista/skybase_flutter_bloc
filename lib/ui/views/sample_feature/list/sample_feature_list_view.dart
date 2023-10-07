import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_controller.dart';
import 'package:skybase/ui/widgets/base/sky_pagination_view.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureListView extends StatelessWidget {
  static const String route = '/user-list';

  const SampleFeatureListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Sample Feature List'));
    // return Scaffold(
    //   appBar: SkyAppBar.secondary(title: 'txt_list_users'.tr),
    //   body: SkyPaginationView<SampleFeature>(
    //     pagingController: controller.pagingController,
    //     onRefresh: controller.onRefresh,
    //     itemBuilder: (BuildContext context, item, int index) {
    //       return ListTile(
    //         onTap: () => controller.onChooseUser(
    //           id: item.id,
    //           username: item.username,
    //         ),
    //         leading: SkyImage(
    //           shapeImage: ShapeImage.circle,
    //           size: 30,
    //           src: '${item.avatarUrl}&s=200',
    //         ),
    //         title: Text(item.username.toString()),
    //         subtitle: Text(
    //           item.gitUrl.toString(),
    //           style: AppStyle.body2,
    //         ),
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: AppColors.primary,
    //     onPressed: () {
    //       StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_LIST);
    //       StorageManager.find.delete(CachedKey.SAMPLE_FEATURE_DETAIL);
    //     },
    //     child: const Icon(Icons.delete, color: Colors.white),
    //   ),
    // );
  }
}
