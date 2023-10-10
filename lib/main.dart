import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/config/themes/theme_manager/theme_manager.dart';
import 'package:skybase/ui/views/intro/bloc/intro_bloc.dart';
import 'package:skybase/ui/views/login/bloc/login_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/views/settings/bloc/setting_bloc.dart';

import 'app_configuration.dart';
import 'config/themes/app_theme.dart';
import 'config/observer/app_bloc_observer.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';
import 'ui/views/profile/bloc/profile_bloc.dart';
import 'ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';

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
        BlocProvider(
          create: (_) => sl<AuthManager>()..init(),
        ),
        BlocProvider(
          create: (_) => sl<ThemeManager>()..init(),
        ),
        BlocProvider(
          create: (_) => sl<IntroBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<SampleFeatureListBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<SampleFeatureDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<ProfileRepositoryBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<SettingBloc>(),
        ),
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
