import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_wrapper.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

import 'component/repository/profile_repository_view.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  static const String route = '/profile';

  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: (authManager, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Profile'),
              SkyButton(
                text: 'Logout',
                onPressed: () async {
                  LoadingDialog.show(context);
                  authManager.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Get.theme.scaffoldBackgroundColor,
    //     elevation: 0,
    //     actions: [
    //       IconButton(
    //         onPressed: () => Get.toNamed(SettingView.route),
    //         icon: Icon(
    //           CupertinoIcons.settings,
    //           color: Get.theme.iconTheme.color,
    //         ),
    //       ),
    //       const SizedBox(width: 8),
    //     ],
    //   ),
    //   body: Obx(
    //     () => SkyView.page(
    //       loadingEnabled: controller.isLoading,
    //       errorEnabled: controller.isError,
    //       emptyEnabled: controller.isEmpty,
    //       onRetry: controller.onRefresh,
    //       onRefresh: controller.onRefresh,
    //       child: SingleChildScrollView(
    //         physics: const AlwaysScrollableScrollPhysics(),
    //         padding: const EdgeInsets.symmetric(horizontal: 24),
    //         child: Column(
    //           children: [
    //             SkyImage(
    //               shapeImage: ShapeImage.circle,
    //               size: 40,
    //               src: '${controller.dataObj.value?.avatarUrl}&s=200',
    //             ),
    //             const SizedBox(height: 12),
    //             Text(
    //               controller.dataObj.value?.name ?? '--',
    //               style: AppStyle.headline3,
    //             ),
    //             Text(controller.dataObj.value?.bio ?? '--'),
    //             const SizedBox(height: 24),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Text(
    //                       '${controller.dataObj.value?.repository ?? 0}',
    //                       style: AppStyle.headline3,
    //                     ),
    //                     const Text('Repository'),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text(
    //                       '${controller.dataObj.value?.followers ?? 0}',
    //                       style: AppStyle.headline3,
    //                     ),
    //                     const Text('Follower'),
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text(
    //                       '${controller.dataObj.value?.following ?? 0}',
    //                       style: AppStyle.headline3,
    //                     ),
    //                     const Text('Following'),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 24),
    //             Row(
    //               children: [
    //                 const Icon(Icons.location_city),
    //                 Text(' ${controller.dataObj.value?.company ?? '--'}'),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 const Icon(Icons.location_on),
    //                 Text(' ${controller.dataObj.value?.location ?? '--'}'),
    //               ],
    //             ),
    //             const SizedBox(height: 8),
    //             const Divider(color: Colors.black38),
    //             Row(
    //               children: [
    //                 Text('Repository List', style: AppStyle.headline3),
    //               ],
    //             ),
    //             const SizedBox(height: 12),
    //             const ProfileRepositoryView(),
    //             const SizedBox(height: 12),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
