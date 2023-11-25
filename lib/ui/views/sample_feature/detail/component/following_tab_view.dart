import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class FollowingTabView extends StatelessWidget {
  const FollowingTabView({super.key, required this.data});

  final SampleFeature data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: data.followingList?.length ?? 0,
      itemBuilder: (_, index) {
        final SampleFeature? user = data.followingList?[index];
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
