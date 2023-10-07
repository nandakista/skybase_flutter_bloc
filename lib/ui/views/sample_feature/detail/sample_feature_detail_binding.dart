import 'package:get/get.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources_impl.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_controller.dart';

class SampleFeatureDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SampleFeatureDetailController(
        repository:
            SampleFeatureRepositoryImpl(apiService: SampleFeatureSourcesImpl()),
      ),
    );
  }
}
