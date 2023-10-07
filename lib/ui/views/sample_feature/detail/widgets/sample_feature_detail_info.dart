import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';

class SampleFeatureDetailInfo extends GetView<SampleFeatureDetailController> {
  const SampleFeatureDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: controller.detailInfoKey,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(controller.dataObj.value?.name ?? '--', style: AppStyle.headline4),
            Text(controller.dataObj.value?.bio ?? '--'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_city),
                Text(' ${controller.dataObj.value?.company ?? '--'}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                Text(' ${controller.dataObj.value?.location ?? '--'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
