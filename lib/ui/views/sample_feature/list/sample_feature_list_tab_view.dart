import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_tab_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';

class SampleFeatureListTabView extends StatelessWidget {
  static const String route = '/user-list';

  const SampleFeatureListTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Github Users'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Nanda'),
            Tab(text: 'Permana'),
          ]),
        ),
        body: const TabBarView(
          children: [
            SampleFeatureListView<NandaBloc>(),
            SampleFeatureListView<PermanaBloc>(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () async {
            LoadingDialog.show(context);
            await HydratedBloc.storage.clear();
            if (context.mounted) LoadingDialog.dismiss(context);
          },
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }
}
