import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';
import 'package:skybase/ui/widgets/base/state_view.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

import 'component/repository/profile_repository_view.dart';

class ProfileView extends StatelessWidget {
  static const String route = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigation.instance.push(context, SettingView.route),
            icon: Icon(
              CupertinoIcons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final bloc = context.read<ProfileBloc>();
          final data = (state is ProfileLoaded) ? state.result : null;
          final errMessage = (state is ProfileError) ? state.message : null;

          return StateView.page(
            loadingEnabled: state is ProfileLoading,
            errorEnabled: state is ProfileError,
            emptyEnabled: false,
            errorTitle: errMessage,
            onRetry: () => bloc.onRefresh(context),
            onRefresh: () => bloc.onRefresh(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SkyImage(
                    shapeImage: ShapeImage.circle,
                    size: 40,
                    src: '${data?.avatarUrl}&s=200',
                    enablePreview: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data?.name ?? '--',
                    style: AppStyle.headline3,
                  ),
                  Text(data?.bio ?? '--'),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${data?.repository ?? 0}',
                            style: AppStyle.headline3,
                          ),
                          const Text('Repository'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${data?.followers ?? 0}',
                            style: AppStyle.headline3,
                          ),
                          const Text('Follower'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${data?.following ?? 0}',
                            style: AppStyle.headline3,
                          ),
                          const Text('Following'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.location_city),
                      Text(' ${data?.company ?? '--'}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(' ${data?.location ?? '--'}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.black38),
                  Row(
                    children: [
                      Text('Repository List', style: AppStyle.headline3),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const ProfileRepositoryView(),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
