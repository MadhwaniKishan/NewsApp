import 'package:intl/intl.dart';

class Utility {
  // return number of days before which article was published
  static int getDifferenceInDaysFromToday(String publishedDate) {
    return DateTime.now().difference(DateTime.parse(publishedDate)).inDays;
  }

  // return formatted date. Example : 18 October 2020
  static String getFormattedDate(String publishedDate) {
    DateTime _parseDt = DateTime.parse(publishedDate);
    var _formatter = new DateFormat("d MMMM y");
    return _formatter.format(_parseDt);
  }
}
