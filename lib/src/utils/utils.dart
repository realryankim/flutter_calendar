import 'package:intl/intl.dart';

class Utils {
  static String title = 'Calendar Events App';

  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  // 날짜 포멧
  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  // 시간 포멧
  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }
}
