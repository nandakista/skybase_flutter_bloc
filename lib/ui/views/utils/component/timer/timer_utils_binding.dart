import 'package:get/get.dart';
import 'package:skybase/core/modules/timer/timer_tag.dart';
import 'package:skybase/core/modules/timer/timer_module.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_controller.dart';

class TimerUtilsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TimerModule(), tag: TimerTag.timer1);
    Get.put(TimerModule(), tag: TimerTag.timer2);
    Get.lazyPut(() => TimerUtilsController());
  }
}