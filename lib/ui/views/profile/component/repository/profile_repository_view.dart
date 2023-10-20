import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'package:skybase/ui/widgets/base/sky_view.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class ProfileRepositoryView extends StatefulWidget {
  const ProfileRepositoryView({Key? key}) : super(key: key);

  @override
  State<ProfileRepositoryView> createState() => _ProfileRepositoryViewState();
}

class _ProfileRepositoryViewState extends State<ProfileRepositoryView> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<ProfileRepositoryBloc>().add(LoadRepositories()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileRepositoryBloc, ProfileRepositoryState>(
      builder: (context, state) {
        final bloc = context.read<ProfileRepositoryBloc>();
        final data = (state is ProfileRepositoryLoaded) ? state.result : null;
        final errMessage =
            (state is ProfileRepositoryError) ? state.message : null;

        return SkyView.component(
          loadingEnabled: state is ProfileRepositoryLoading,
          errorEnabled: state is ProfileRepositoryError,
          emptyEnabled: state is ProfileRepositoryInitial,
          errorTitle: errMessage,
          onRetry: () => bloc.add(LoadRepositories()),
          loadingView: const ShimmerList(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              final item = data?[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SkyImage(
                  shapeImage: ShapeImage.circle,
                  size: 30,
                  src: '${item?.owner.avatarUrl}&s=200',
                ),
                title: Text(item?.name ?? '', style: AppStyle.body2),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language: ${item?.language ?? '--'}',
                      style: AppStyle.body3,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_border,
                              size: 16,
                            ),
                            Text(
                              ' ${item?.totalStar}',
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
                              ' ${item?.totalWatch}',
                              style: AppStyle.body3,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SkyImage(
                              src: 'assets/images/fork.svg',
                              height: 14,
                              color: AppColors.systemDarkGrey,
                            ),
                            Text(
                              ' ${item?.totalFork}',
                              style: AppStyle.body3,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
