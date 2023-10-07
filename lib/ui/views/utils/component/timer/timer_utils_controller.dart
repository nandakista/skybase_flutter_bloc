import 'package:get/get.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/core/modules/timer/timer_tag.dart';
import 'package:skybase/core/modules/timer/timer_helper.dart';
import 'package:skybase/core/modules/timer/timer_module.dart';

class TimerUtilsController extends GetxController {
  final timer1Ctr = Get.find<TimerModule>(tag: TimerTag.timer1);
  final timer2Ctr = Get.find<TimerModule>(tag: TimerTag.timer2);

  final currTimeTimer2 = 'Waiting...'.obs;

  @override
  void onInit() {
    _startTimer();
    Future.delayed(const Duration(seconds: 2)).then((value) => _startTimer2());
    super.onInit();
  }

  /// Timer 1
  void _startTimer() {
    timer1Ctr.startTimer(
      updateId: 'timer_test',
      time: TimerHelper.startTimer(hours: 3),
      onChanged: (int time) {
        update(['count_down_timer']);
      },
    );
  }

  /// Timer 2
  void _startTimer2() {
    timer2Ctr.startTimer(
      updateId: 'timer_test2',
      time: TimerHelper.startTimer(seconds: 3),
      onStart: (item) {
        currTimeTimer2.value = item.toString();
      },
      onChanged: (int time) {
        currTimeTimer2.value = time.toString();
      },
      onFinished: () {
        currTimeTimer2.value = 'Timer End';
        SnackBarHelper.normal(context: Get.context!, message: 'Timer 2 is done');
      },
    );
  }
}
