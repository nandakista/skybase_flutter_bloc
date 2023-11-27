import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class RepoTabView extends StatelessWidget {
  const RepoTabView({super.key, required this.data});

  final SampleFeature data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: data.repositoryList?.length ?? 0,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (_, index) {
        final Repo? repos = data.repositoryList?[index];
        return (repos == null)
            ? const Center(
          child: Text('User belum mem-follow siapapun'),
        )
            : ListTile(
          leading: SkyImage(
            size: 30,
            shapeImage: ShapeImage.circle,
            src: '${repos.owner.avatarUrl}&s=200',
          ),
          title: Text(repos.name.toString(), style: AppStyle.body2),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language: ${repos.language ?? '--'}',
                style: AppStyle.body3,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border,
                          size: 16,
                        ),
                        Text(
                          ' ${repos.totalStar}',
                          style: AppStyle.body3,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 16,
                        ),
                        Text(
                          ' ${repos.totalWatch}',
                          style: AppStyle.body3,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SkyImage(
                          src: 'assets/images/ic_fork.svg',
                          height: 14,
                          color: Colors.grey,
                        ),
                        Text(
                          ' ${repos.totalFork}',
                          style: AppStyle.body3,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
