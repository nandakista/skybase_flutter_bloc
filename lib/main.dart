import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skybase/config/environment/app_env.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/config/themes/theme_manager/theme_manager.dart';
import 'package:skybase/ui/widgets/env_banner.dart';

import 'config/environment/app_configuration.dart';
import 'config/themes/app_theme.dart';
import 'config/observer/app_bloc_observer.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';
import 'ui/views/404_500/crash_error_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await EasyLocalization.ensureInitialized();
  await ServiceLocator.init();

  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      path: 'lib/core/localization/languages',
      supportedLocales: LocaleManager.instance.locales.values.toList(),
      startLocale: LocaleManager.instance.getCurrentLocale,
      fallbackLocale: LocaleManager.instance.fallbackLocale,
      useFallbackTranslations: true,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeManager>()..init()),
        // Add global bloc provider here..
      ],
      child: BlocBuilder<ThemeManager, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConfiguration.appName,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: (state is IsDarkMode) ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
            routerDelegate: AppRoutes.router.routerDelegate,
            builder: (BuildContext context, child) {
              ErrorWidget.builder = (FlutterErrorDetails error) {
                return CrashErrorView(errorDetails: error);
              };
              return EnvBanner(
                title: AppEnv.env.title,
                color: AppEnv.env.color,
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
