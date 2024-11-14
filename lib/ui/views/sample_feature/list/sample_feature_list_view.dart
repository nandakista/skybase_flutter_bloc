import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/widgets/base/pagination_state_view.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_list.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class SampleFeatureListView<T extends SampleFeatureListBloc>
    extends StatelessWidget {
  const SampleFeatureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, SampleFeatureListState>(
      listener: (BuildContext context, SampleFeatureListState state) {
        T bloc = context.read<T>();
        if (state is SampleFeatureListError) {
          bloc.loadError(state.message);
        } else if (state is SampleFeatureListLoaded) {
          bloc.loadNextData(data: state.result);
        }
      },
      builder: (context, state) {
        T bloc = context.read<T>();
        return PaginationStateView<SampleFeature>.list(
          pagingController: bloc.pagingController,
          loadingView: const ShimmerSampleFeatureList(),
          onRefresh: () => bloc.onRefresh(context),
          onRetry: () => bloc.onRefresh(context),
          itemBuilder: (BuildContext context, item, int index) {
            return ListTile(
              onTap: () {
                Navigation.instance.push(
                  context,
                  SampleFeatureDetailView.route,
                  arguments: {
                    'id': item.id,
                    'username': item.username,
                  },
                );
              },
              leading: SkyImage(
                shapeImage: ShapeImage.circle,
                size: 30,
                src: '${item.avatarUrl}&s=200',
              ),
              title: Text(item.username.toString()),
              subtitle: Text(
                item.gitUrl.toString(),
                style: AppStyle.body2,
              ),
            );
          },
        );
      },
    );
  }
}
