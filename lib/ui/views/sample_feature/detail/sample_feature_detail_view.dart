import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_header.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_info.dart';
import 'package:skybase/ui/views/sample_feature/detail/widgets/sample_feature_detail_tab.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_detail.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class SampleFeatureDetailView extends GetView<SampleFeatureDetailController> {
  static const String route = '/user-detail';

  const SampleFeatureDetailView({
    Key? key,
    required this.idArgs,
    required this.usernameArgs,
  }) : super(key: key);

  final int idArgs;
  final String usernameArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: controller.dataObj.value?.username),
      body: SafeArea(
        child: Obx(
          () => SkyView.page(
            loadingEnabled: controller.isLoading,
            errorEnabled: controller.isError,
            emptyEnabled: controller.isEmpty,
            loadingView: const ShimmerDetail(),
            errorTitle: controller.errorMessage.value,
            onRefresh: () => controller.onRefresh(),
            onRetry: () => controller.onRefresh(),
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SampleFeatureDetailHeader(),
                  SampleFeatureDetailInfo(),
                  SampleFeatureDetailTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
