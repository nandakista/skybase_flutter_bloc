import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skybase/app_configuration.dart';
import 'package:skybase/config/auth_manager/auth_wrapper.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/themes/theme_manager/theme_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/ui/views/settings/bloc/setting_bloc.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SettingView extends StatefulWidget {
  static const String route = '/setting';

  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SettingBloc>().add(InitLocale()));
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      builder: (authManager, state) => ColoredStatusBar(
        brightness: Brightness.dark,
        child: Scaffold(
          appBar: SkyAppBar.secondary(title: 'txt_setting'),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              12,
              24,
              MediaQuery.paddingOf(context).bottom + 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${'txt_version'} ${AppConfiguration.appVersion}',
                  style: AppStyle.body2.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                SkyButton(
                  onPressed: () {
                    LoadingDialog.show(context);
                    authManager.logout();
                  },
                  text: 'txt_logout',
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(child: Text('txt_language')),
                    Flexible(
                      child: BlocBuilder<SettingBloc, SettingState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('ENG'),
                              Radio(
                                value: jsonEncode({
                                  'name': 'English',
                                  'locale': 'en',
                                }),
                                groupValue: jsonEncode(state.language),
                                onChanged: (value) {
                                  context
                                      .read<SettingBloc>()
                                      .add(UpdateLocale(value.toString()));
                                },
                              ),
                              const Text('ID'),
                              Radio(
                                value: jsonEncode({
                                  'name': 'Indonesia',
                                  'locale': 'id',
                                }),
                                groupValue: jsonEncode(state.language),
                                onChanged: (value) {
                                  context
                                      .read<SettingBloc>()
                                      .add(UpdateLocale(value.toString()));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
                const Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('txt_dark_mode'),
                    BlocBuilder<ThemeManager, ThemeState>(
                      builder: (context, state) => Switch(
                        value: state is IsDarkMode,
                        onChanged: (value) {
                          context.read<ThemeManager>().changeTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
