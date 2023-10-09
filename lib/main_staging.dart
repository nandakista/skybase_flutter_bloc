import './main.dart' as main_app;
import 'config/environment/app_env.dart';

void main() async {
  AppEnv.set(Environment.STAGING);
  main_app.main();
}