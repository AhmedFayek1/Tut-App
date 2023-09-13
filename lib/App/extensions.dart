import 'package:tut_app/App/constants.dart';

extension nonNullString on String?{
  String orNull()
  {
    if(this == null) {
      return AppConstants.emptyString;
    } else {
      return this!;
    }
  }
}

extension nonNullInt on int?{
  int orZero()
  {
    if(this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}