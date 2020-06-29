import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTimestamp(
    int timestamp, {
    String outputFormat = "hh:mm a",
  }) {
    var format = new DateFormat(outputFormat);
    // var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format.format(date);
  }

  static bool isSameDay(
    int timestamp,
    int otherTimestamp,
  ) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    var otherDate = new DateTime.fromMillisecondsSinceEpoch(otherTimestamp);

    if (date.day == otherDate.day &&
        date.month == otherDate.month &&
        date.year == otherDate.year) {
      return true;
    } else {
      return false;
    }
  }
}
