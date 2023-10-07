// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:skybase/core/base/pagination_controller.dart';
// import 'package:skybase/data/models/sample_feature/sample_feature.dart';
// import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
// import 'package:skybase/data/sources/local/cached_key.dart';
// import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';
//
// class SampleFeatureListController extends PaginationController<SampleFeature> {
//   final SampleFeatureRepository repository;
//
//   SampleFeatureListController({required this.repository});
//
//   @override
//   void onInit() {
//     getCache(() => getUsers());
//
//     // Only fetch data
//     // loadData(() => getUsers());
//     super.onInit();
//   }
//
//   @override
//   String get cachedKey => CachedKey.SAMPLE_FEATURE_LIST;
//
//   void getUsers() async {
//     try {
//       final response = await repository.getUsers(
//         page: page,
//         perPage: perPage,
//       );
//       saveCacheAndFinish(data: response);
//
//       // Only fetch data
//       // finishLoadData(data: response);
//     } catch (e) {
//       debugPrint('Error : $e');
//       showError(e.toString());
//     }
//   }
//
//   void onChooseUser({required int id, required String username}) {
//     Get.toNamed(
//       SampleFeatureDetailView.route,
//       arguments: {
//         'id': id,
//         'username': username,
//       },
//     );
//   }
// }
