import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/core/extension/size_extension.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/follower_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/following_tab_view.dart';
import 'package:skybase/ui/views/sample_feature/detail/component/repo_tab_view.dart';

class SampleFeatureDetailTab extends StatelessWidget {
  const SampleFeatureDetailTab({super.key, required this.data});

  final SampleFeature? data;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.secondary,
            tabs: [
              Tab(text: 'Repositories'),
              Tab(text: 'Followers'),
              Tab(text: 'Followings'),
            ],
          ),
          data != null
              ? SizedBox(
                  height: 56.h(context),
                  child: TabBarView(
                    children: [
                      RepoTabView(data: data!),
                      FollowerTabView(data: data!),
                      FollowingTabView(data: data!),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
