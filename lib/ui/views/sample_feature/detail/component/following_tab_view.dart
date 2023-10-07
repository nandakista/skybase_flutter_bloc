import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class FollowingTabView extends GetView<SampleFeatureDetailController> {
  const FollowingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: controller.dataObj.value?.followingList?.length ?? 0,
      itemBuilder: (_, index) {
        final SampleFeature? user =
            controller.dataObj.value?.followingList![index];
        return (user == null)
            ? const Center(
                child: Text('User belum mem-follow siapapun'),
              )
            : ListTile(
                leading: SkyImage(
                  size: 30,
                  shapeImage: ShapeImage.circle,
                  src: '${user.avatarUrl}&s=200',
                  // onTap: () => controller.onChooseUser(user: user),
                ),
                title: Text(user.username.toString()),
                subtitle: Text(
                  user.gitUrl.toString(),
                  style: AppStyle.body2,
                ),
              );
      },
    );
  }
}
