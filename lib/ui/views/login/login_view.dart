import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/login/bloc/login_bloc.dart';
import 'package:skybase/ui/widgets/keyboard_dismissible.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class LoginView extends StatefulWidget {
  static const String route = '/login';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool isHiddenPassword = true;

  void onHidePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginFailed) {
                  LoadingDialog.dismiss(context);
                  DialogHelper.failed(
                    context: context,
                    message: state.message.toString(),
                  );
                } else if (state is LoginSuccess) {
                  LoadingDialog.dismiss(context);
                } else {
                  LoadingDialog.show(context);
                }
              },
              builder: (context, state) {
                final bloc = context.read<LoginBloc>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('txt_login'.tr(), style: AppStyle.headline2),
                              const SizedBox(height: 10),
                              Text(
                                'txt_login_subtitle'.tr(),
                                style: AppStyle.subtitle4,
                              ),
                            ],
                          ),
                        ),
                        const Flexible(
                          child: Image(
                            image: AssetImage('assets/images/img_login.png'),
                            width: 250,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          SkyFormField(
                            label: 'txt_phone'.tr(),
                            hint: 'txt_phone'.tr(),
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone,
                            validator: (value) => ValidatorHelper.field(
                              title: 'txt_phone'.tr(),
                              value: value.toString(),
                              regex: AppRegex.phone,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SkyPasswordFormField(
                            label: 'txt_password'.tr(),
                            hint: 'txt_password'.tr(),
                            controller: passwordController,
                            icon: Icons.lock,
                            hiddenText: isHiddenPassword,
                            endIcon: IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: onHidePassword,
                            ),
                            validator: (value) => ValidatorHelper.field(
                              title: 'txt_password'.tr(),
                              value: value.toString(),
                              regex: AppRegex.password,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SkyButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (ValidatorHelper.validateForm(formKey)) {
                                bloc.add(
                                  SubmitLogin(
                                    phoneController.text,
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: 'txt_login'.tr(),
                            icon: Icons.arrow_forward,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        SkyButton(
                          onPressed: () => bloc.add(BypassLogin()),
                          text: 'txt_skip'.tr(),
                          icon: Icons.arrow_forward,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('txt_forgot_password'.tr()),
                            InkWell(
                              child: Text(
                                'txt_reset'.tr(),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('txt_dont_have_account'.tr()),
                            InkWell(
                              child: Text(
                                'txt_register'.tr(),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
