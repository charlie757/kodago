import 'package:intl/intl.dart';

class TimeFormat {
  static String convertTime(String date) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(date));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    return DateFormat('jm').format(dateTime);
  }

  static String convertDate(String date) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(date));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static convertDateWithTime(String dateString) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(dateString));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();
    return "${DateFormat('dd MMM yyyy').format(dateTime)} ${DateFormat('jm').format(dateTime)}";
  }
}
