import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/modules/timer/timer_helper.dart';
import 'package:skybase/core/modules/timer/timer_module.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_controller.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class TimerUtilsView extends GetView<TimerUtilsController> {
  static const String route = '/sample-timer';
  const TimerUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Timer Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Sample Timer', style: AppStyle.subtitle2),
            const SizedBox(height: 12),
            GetBuilder<TimerUtilsController>(
              id: 'count_down_timer',
              builder: (controller) {
                TimeLeftData timerData = TimerHelper.intToTimeLeftData(
                  controller.timer1Ctr.currentTime.value,
                );
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeItem(time: timerData.hour, title: 'Hour'),
                    const SizedBox(width: 12),
                    Text(':', style: AppStyle.headline1),
                    const SizedBox(width: 12),
                    _buildTimeItem(time: timerData.minutes, title: 'Minutes'),
                    const SizedBox(width: 12),
                    Text(':', style: AppStyle.headline1),
                    const SizedBox(width: 12),
                    _buildTimeItem(time: timerData.second, title: 'Second'),
                  ],
                );
              },
            ),
            const SizedBox(height: 36),
            Obx(
              ()=> Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.currTimeTimer2.value, style: AppStyle.headline2),
                  Text('Raw Timer', style: AppStyle.subtitle3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTimeItem({required String time, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(time, style: AppStyle.headline1),
        Text(title, style: AppStyle.subtitle3),
      ],
    );
  }
}
