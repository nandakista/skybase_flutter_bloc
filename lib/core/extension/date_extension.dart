import 'package:intl/intl.dart';
import 'package:skybase/core/localization/locale_helper.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
extension DateTimeExt on DateTime {
  DateTime copy() =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc);

  String format([
    String format = 'dd MMM yyyy',
    String? idFormat,
  ]) {
    String local = StorageManager.instance.get(StorageKey.CURRENT_LOCALE) ?? 'id';
    return LocaleHelper.builder<String>(
      en: DateFormat(format, local).format(this),
      id: DateFormat(idFormat ?? format, local).format(this),
    );
  }

  String get todayddMMMyyyy => format('EEEE, dd MMM yyyy');

  String get toHHmm => format('HH:mm');

  String get toyyyyMMdd => format('yyyy-MM-dd');

  String get todMMyyyy => format('d MMMM yyyy');

  String get toddMMyyyy => format('dd-MMMM-yyyy');

  String get toMMddyyyy => format('MM/dd/yyyy');

  String get toTimestamp => format('yyy-MM-dd HH:mm:ss');
}
