import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Presentation/Resources/assets_manager.dart';
import 'package:tut_app/Presentation/Resources/language_manager.dart';
import 'package:tut_app/Presentation/Resources/router_manager.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';
import 'package:tut_app/Presentation/Resources/values_manager.dart';

import '../../../../App/app_preferences.dart';
import '../../../../Data/Data_Sources/local_data_source.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: SvgPicture.asset(ImagesManager.settings),
                title: const Text(StringsManager.changeLanguage).tr(),
                trailing: Transform(
                  transform: Matrix4.identity()..rotateY(isRTL() ? 3.14 : 0),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ImagesManager.right),
                ),

                onTap: () {
                  _changeLanguage(context);
                },
              ),
              _line(),
              ListTile(
                leading: SvgPicture.asset(ImagesManager.contactUs),
                title: Text(StringsManager.contactUs.tr()),
                trailing: Transform(
                transform: Matrix4.identity()..rotateY(isRTL() ? 3.14 : 0),
                alignment: Alignment.center,
                child: SvgPicture.asset(ImagesManager.right),
              ),

                onTap: () {
                  _contactUs(context);
                },
              ),
              _line(),
              ListTile(
                leading: SvgPicture.asset(ImagesManager.inviteFriends),
                title: Text(StringsManager.inviteFriends.tr()),
                trailing: Transform(
                  transform: Matrix4.identity()..rotateY(isRTL() ? 3.14 : 0),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ImagesManager.right),
                ),
                onTap: () {
                  inviteFriends(context);
                },
              ),
              _line(),
              ListTile(
                leading: SvgPicture.asset(ImagesManager.logout),
                title: Text(StringsManager.logout.tr()),
                trailing: Transform(
                  transform: Matrix4.identity()..rotateY(isRTL() ? 3.14 : 0),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(ImagesManager.right),
                ),
                onTap: () {
                  logout(context);
                },
              ),
            ],

    ),
        ));
  }

  bool isRTL()
  {
    return context.locale == localAR;
  }

  Widget _line() {
    return const Divider(
      color: Colors.grey,
      height: 0.5,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
    );
  }

  void _changeLanguage(BuildContext context) {

    _appPreferences.setLanguage();
    Phoenix.rebirth(context);

  }

  void _contactUs(BuildContext context) {

  }

  void inviteFriends(BuildContext context) {

  }

  void logout(BuildContext context) {
    //navigate to login screen
    Navigator.pushReplacementNamed(context, AppRoutes.login);

    //clear shared preferences
    _appPreferences.logout();

    //clear local data source
    _localDataSource.clearCache();
  }
}
