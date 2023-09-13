import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';
import 'package:tut_app/Presentation/Login/View_Model/login_view_model.dart';
import 'package:tut_app/Presentation/Resources/color_manager.dart';
import 'package:tut_app/Presentation/Resources/router_manager.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';
import '../../Resources/assets_manager.dart';
import '../../Resources/values_manager.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  AppPreferences appPreferences = instance<AppPreferences>();

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void bindViewModel() {
    _loginViewModel.start();
    userNameController.addListener(() {
      _loginViewModel.setUserName(userNameController.text);
    });

    passwordController.addListener(() {
      _loginViewModel.setPassword(passwordController.text);
    });

    _loginViewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn == true)
        {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            appPreferences.setIsUserLoggedIn();
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          });
        }
    });
  }

  @override
  void initState() {

    bindViewModel();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowStates>(
        stream: _loginViewModel.outputStateStream,
          builder: (context,snapshot) {
          return snapshot.data?.getScreenWidget(context,getContent(),() {_loginViewModel.login();}) ?? getContent();
          }
      ),
    );
  }


  Widget getContent() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: ColorManager.white,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: AppSizes.s100),
                const Center(
                  child: Image(
                    image: AssetImage(ImagesManager.splash),
                  ),
                ),
                const SizedBox(height: AppSizes.s20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
                  child: Column(
                    children: [
                      StreamBuilder<bool>(
                          stream: _loginViewModel.userNameOutput,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: StringsManager.hintUserName.tr(),
                                label: Text(StringsManager.hintUserName.tr()),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringsManager.userNameError.tr(),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: AppSizes.s15,
                      ),
                      StreamBuilder<bool>(
                          stream: _loginViewModel.passwordOutput,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: StringsManager.hintPassword.tr(),
                                label:  Text(StringsManager.hintPassword.tr()),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringsManager.passwordError.tr(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return StringsManager.passwordError.tr();
                                }
                                return null;
                              },
                            );
                          }),
                      const SizedBox(
                        height: AppSizes.s20,
                      ),
                      StreamBuilder<bool>(
                          stream: _loginViewModel.isAllDataValidOutput,
                          builder: (context, snapshot) {
                            return SizedBox(
                              width: double.infinity,
                              height: AppSizes.s40,
                              child: ElevatedButton(
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                        _loginViewModel.login();
                                      }
                                    : null,
                                child: Text(StringsManager.login.tr()),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s20),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.forgotPassword);
                          },
                          child: Text(
                            StringsManager.forgotPassword.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      Row(
                        children: [
                          Text(
                            StringsManager.dontHaveAccount.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            width: AppPadding.p4,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.register);
                            },
                            child: Text(
                              StringsManager.signUp.tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
