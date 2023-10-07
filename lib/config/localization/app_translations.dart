import 'package:get/get.dart';
import 'package:skybase/config/localization/languages/english.dart';
import 'package:skybase/config/localization/languages/indonesian.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'id': id,
      };
}
