import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/intro/bloc/intro_bloc.dart';
import 'package:skybase/ui/views/login/bloc/login_bloc.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'package:skybase/ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/views/settings/bloc/setting_bloc.dart';

class AppBlocs {
  static List get provider {
    return [
      BlocProvider(create: (_) => sl<IntroBloc>()),
      BlocProvider(create: (_) => sl<LoginBloc>()),
      BlocProvider(create: (_) => sl<SampleFeatureListBloc>()),
      BlocProvider(create: (_) => sl<SampleFeatureDetailBloc>()),
      BlocProvider(create: (_) => sl<ProfileBloc>()),
      BlocProvider(create: (_) => sl<ProfileRepositoryBloc>()),
      BlocProvider(create: (_) => sl<SettingBloc>()),
    ];
  }
}
