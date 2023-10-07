import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_binding.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_view.dart';

final timerUtilsRoute = [
  GoRoute(
    path: TimerUtilsView.route,
    builder: (context, state) => const TimerUtilsView(),
  ),
];
