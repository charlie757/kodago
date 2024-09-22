import 'package:intl/intl.dart';

class TimeFormat {
  static String convertDate(String date) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(date));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();

    return '${DateFormat('dd, MMMM yyyy').format(dateTime)}, ${DateFormat('jm').format(dateTime)}';
  }

  static convertDate1(String dateString) {
    DateFormat inputFormat = DateFormat("dd-MM-yyyy");
    DateTime parsedDate = inputFormat.parse(dateString);

    // Adjust the time to 00:00:00.000
    DateTime formattedDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    print(formattedDate); // Output: 2024-08-09 00:00:00.000
    return formattedDate;
  }
}
