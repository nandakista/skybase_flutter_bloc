import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

class SampleFeatureDetailController extends BaseController<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureDetailController({required this.repository});

  final GlobalKey headerKey = GlobalKey();
  final GlobalKey detailInfoKey = GlobalKey();
  final headerWidget = Rxn<Size>();
  final detailInfoWidget = Rxn<Size>();

  late int idArgs;
  late String usernameArgs;

  @override
  void onInit() {
    super.onInit();
    idArgs = Get.arguments['id'];
    usernameArgs = Get.arguments['username'];
  }

  @override
  void onReady() async {
    getCache(() => getDetailUser());

    // Only fetch data
    // loadData(() => getDetailUser());
    super.onReady();
  }

  @override
  void refreshPage() {
    getDetailUser();
    super.refreshPage();
  }

  @override
  String get cachedId => idArgs.toString();

  @override
  // Only save last cache
  String get cachedKey => CachedKey.SAMPLE_FEATURE_DETAIL;

  // Save every detail cache
  // String get storageName => CachedKey.SAMPLE_FEATURE_DETAIL + cacheId;

  Future<void> getDetailUser() async {
    showLoading();
    try {
      final response = await repository.getDetailUser(
        id: idArgs,
        username: usernameArgs,
      );
      saveCacheAndFinish(data: response);

      // Only fetch data
      // finishLoadData(data: response);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      showError(e.toString());
    }
  }
}
