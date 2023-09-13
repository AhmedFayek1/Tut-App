import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/Presentation/Common/State_Renderer/state_renderer_implementer.dart';
import 'package:tut_app/Presentation/Resources/color_manager.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';

import '../../../App/dependency_injection.dart';
import '../../Resources/assets_manager.dart';
import '../../Resources/values_manager.dart';
import '../View_Model/view_model.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel forgotPasswordViewModel = instance<ForgotPasswordViewModel>();

  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void bindViewModel() {
    forgotPasswordViewModel.start();
    emailController.addListener(() {
      forgotPasswordViewModel.setEmail(emailController.text);
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
          stream: forgotPasswordViewModel.outputStateStream,
          builder: (context,snapshot) {
            return snapshot.data?.getScreenWidget(context,getContent(),() {forgotPasswordViewModel.forgotPassword();}) ?? getContent();
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
                  child: Image(image: AssetImage(ImagesManager.splash)),
                ),
                const SizedBox(height: AppSizes.s20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
                  child: Column(
                    children: [
                      StreamBuilder<bool>(
                          stream: forgotPasswordViewModel.userNameOutput,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: StringsManager.hintUserName.tr(),
                                label:  Text(StringsManager.hintUserName.tr()),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringsManager.userNameError.tr(),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: AppSizes.s15,
                      ),
                      const SizedBox(
                        height: AppSizes.s20,
                      ),
                      StreamBuilder<bool>(
                          stream: forgotPasswordViewModel.userNameOutput,
                          builder: (context, snapshot) {
                            return SizedBox(
                              width: double.infinity,
                              height: AppSizes.s40,
                              child: ElevatedButton(
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                  forgotPasswordViewModel.forgotPassword();
                                }
                                    : null,
                                child: Text(StringsManager.resetPassword.tr()),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    forgotPasswordViewModel.dispose();
    super.dispose();
  }
}
