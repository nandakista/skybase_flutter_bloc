import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_view.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_grouped_listview.dart';

class ListUtilsView extends StatelessWidget {
  static const String route = 'list';

  const ListUtilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'List Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildSection(
              page: 1,
              title: 'Sample Grouped ListView',
              content: SkyView.component(
                loadingEnabled: false,
                errorEnabled: false,
                onRetry: () {},
                emptyEnabled: dummyData.isEmpty,
                child: SkyGroupedListView<dynamic, String>(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  sortBy: SortBy.ASC,
                  data: dummyData,
                  separator: const Divider(thickness: 1, height: 12),
                  separatorGroup: const Divider(
                    thickness: 1,
                    height: 12,
                    color: Colors.red,
                  ),
                  groupHeaderBuilder: (group) {
                    return Text(
                      group.toString(),
                      textAlign: TextAlign.center,
                      style: AppStyle.headline4.copyWith(
                        fontWeight: AppStyle.semiBold,
                      ),
                    );
                  },
                  itemBuilder: (context, index, item) {
                    return Text(
                      item['name'],
                      textAlign: TextAlign.start,
                      style: AppStyle.body1,
                    );
                  },
                  groupBy: (element) => element['group'],
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSection({
    required int page,
    required String title,
    required Widget content,
  }) {
    return [
      Text('Page $page', style: AppStyle.subtitle2),
      const SizedBox(height: 12),
      Center(child: Text(title)),
      Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: content,
      ),
    ];
  }
}

final dummyData = [
  {
    'group': 'Jakarta',
    'name': 'Gambir',
    'date': DateTime.now(),
  },
  {
    'group': 'Lampung',
    'name': 'Pringsewu',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Jakarta',
    'name': 'Tebet',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Setrasari',
    'date': DateTime.now().add(const Duration(days: 2)),
  },
  {
    'group': 'Lampung',
    'name': 'Pesawaran',
    'date': DateTime.now().add(const Duration(days: 2)),
  },
  {
    'group': 'Yogyakarta',
    'name': 'Yogyakarta',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Yogyakarta',
    'name': 'Yogyakarta2',
    'date': DateTime.now().add(const Duration(days: 12)),
  },
  {
    'group': 'Lampung',
    'name': 'Metro',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Gedebage',
    'date': DateTime.now().add(const Duration(days: 1)),
  },
  {
    'group': 'Bandung',
    'name': 'Cihanjuang',
    'date': DateTime.now(),
  },
  {
    'group': 'Jakarta',
    'name': 'Sudirman',
    'date': DateTime.now().subtract(const Duration(days: 4)),
  },
];

var dummyDataWithObject = [
  SampleObjectData('Jakarta', 'SCBD'),
  SampleObjectData('Lampung', 'Metro'),
  SampleObjectData('Bandung', 'Gedebage'),
  SampleObjectData('Bandung', 'Cihanjuan'),
  SampleObjectData('Bandung', 'Gedebage'),
  SampleObjectData('Jakarta', 'Sudirman')
];

class SampleObjectData {
  String group;
  String name;

  SampleObjectData(this.group, this.name);
}
