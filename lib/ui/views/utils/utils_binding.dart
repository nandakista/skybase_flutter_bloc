import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';

class UtilsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UtilsController());
  }
}