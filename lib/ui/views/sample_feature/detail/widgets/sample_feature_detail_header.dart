import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureDetailHeader extends GetView<SampleFeatureDetailController> {
  const SampleFeatureDetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: controller.headerKey,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkyImage(
              size: 45,
              shapeImage: ShapeImage.circle,
              src: '${controller.dataObj.value?.avatarUrl}&s=200',
            ),
            Column(
              children: [
                Text(
                  '${controller.dataObj.value?.repository ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Repository'),
              ],
            ),
            Column(
              children: [
                Text(
                  '${controller.dataObj.value?.followers ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Follower'),
              ],
            ),
            Column(
              children: [
                Text(
                  '${controller.dataObj.value?.following ?? 0}',
                  style: AppStyle.headline3,
                ),
                const Text('Following'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
