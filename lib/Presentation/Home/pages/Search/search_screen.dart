import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:tut_app/Presentation/Resources/string_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(StringsManager.search.tr()),
    );
  }
}
