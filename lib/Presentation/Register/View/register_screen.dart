import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/App/dependency_injection.dart';
import '../../Common/State_Renderer/state_renderer_implementer.dart';
import '../../Resources/assets_manager.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/router_manager.dart';
import '../../Resources/string_manager.dart';
import '../../Resources/values_manager.dart';
import '../View_Model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userNameController = TextEditingController();
  var countryMobileCodeController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  final _registerViewModel = instance<RegisterViewModel>();
  final _appPreferences = instance<AppPreferences>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  void bindViewModel() {
    userNameController.addListener(() {
      _registerViewModel.setUserName(userNameController.text);
    });
    mobileNumberController.addListener(() {
      _registerViewModel.setMobileNumber(mobileNumberController.text);
    });

    emailController.addListener(() {
      _registerViewModel.setEmail(emailController.text);
    });

    passwordController.addListener(() {
      _registerViewModel.setPassword(passwordController.text);
    });

    _registerViewModel.isUserRegisteredSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn == true)
      {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.getIsUserLoggedIn();
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
          stream: _registerViewModel.outputStateStream,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, getContent(), () {
                  _registerViewModel.register();
                }) ??
                getContent();
          }),
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
                          stream: _registerViewModel.usernameStream,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (value) {
                                _registerViewModel
                                    .setCountryMobileCode(value.dialCode ?? '');
                              },
                              initialSelection: '+02',
                              showCountryOnly: true,
                              hideMainText: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: const ['+39', 'FR'],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: StreamBuilder<bool>(
                                stream: _registerViewModel.mobileNumberStream,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    controller: mobileNumberController,
                                    decoration: InputDecoration(
                                      hintText: StringsManager.hintPhone.tr(),
                                      label: Text(StringsManager.hintPhone.tr()),
                                      errorText: (snapshot.data ?? true)
                                          ? null
                                          : StringsManager.phoneError.tr(),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.s15,
                      ),
                      StreamBuilder<bool>(
                          stream: _registerViewModel.emailStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: StringsManager.hintEmail.tr(),
                                label: Text(StringsManager.hintEmail.tr()),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringsManager.errorEmail.tr(),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: AppSizes.s15,
                      ),
                      StreamBuilder<bool>(
                          stream: _registerViewModel.passwordStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: StringsManager.hintPassword.tr(),
                                label: Text(StringsManager.hintPassword.tr()),
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : StringsManager.passwordError.tr(),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: AppSizes.s15,
                      ),
                      Container(
                        height: AppSizes.s40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.s8),
                          border: Border.all(color: ColorManager.grey),
                        ),
                        child: GestureDetector(
                          child: getWidget(),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.s20,
                      ),
                      StreamBuilder<bool>(
                          stream: _registerViewModel.isAllDataValidStream,
                          builder: (context, snapshot) {
                            return SizedBox(
                              width: double.infinity,
                              height: AppSizes.s40,
                              child: ElevatedButton(
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                        _registerViewModel.register();
                                      }
                                    : null,
                                child: Text(StringsManager.signUp.tr()),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.s20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: Row(
                      children: [
                        Text(
                          StringsManager.haveAccount.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: AppPadding.p4,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.login);
                          },
                          child: Text(
                            StringsManager.login.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(StringsManager.hintProfilePicture.tr())),
          Flexible(
            child: StreamBuilder<File>(
                stream: _registerViewModel.profilePictureStream,
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? Image.file(snapshot.data!)
                      : Container();
                }),
          ),
          const Flexible(child: Icon(Icons.camera_alt_outlined),),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.image),
                  title: Text(StringsManager.fromGallery.tr()),
                  onTap: () {
                    _pickImageFromGallery(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.photo_camera),
                  title: Text(StringsManager.cameraRoll.tr()),
                  onTap: () {
                    _pickImageFromCamera(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _pickImageFromGallery(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image!.path ?? ''));
  }

  _pickImageFromCamera(ImageSource source) async {
      final image = await _imagePicker.pickImage(source: ImageSource.camera);
      _registerViewModel.setProfilePicture(File(image!.path ?? ''));
    }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }
  
}
