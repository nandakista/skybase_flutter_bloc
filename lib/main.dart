import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/config/themes/theme_manager/theme_manager.dart';
import 'package:skybase/ui/blocs/app_blocs.dart';

import 'app_configuration.dart';
import 'config/themes/app_theme.dart';
import 'ui/blocs/app_bloc_observer.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServiceLocator.init();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      path: 'lib/core/localization/languages',
      supportedLocales: LocaleManager.find.locales.values.toList(),
      startLocale: LocaleManager.find.getCurrentLocale,
      fallbackLocale: LocaleManager.find.fallbackLocale,
      useFallbackTranslations: true,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeManager>()..init()),
        ...AppBlocs.provider,
      ],
      child: BlocBuilder<ThemeManager, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConfiguration.appName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: (state is IsDarkMode) ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
            routerDelegate: AppRoutes.router.routerDelegate,
          );
        },
      ),
    );
  }
}
