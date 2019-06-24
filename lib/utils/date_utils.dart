class DateUtils {
  /// 返回 6月17日 星期一
  static String formatTimeTitle(String time) {
    DateTime d1 = DateTime.parse(time);
    String weekDay = "";
    switch (d1.weekday.toString()) {
      case "1":
        weekDay = "星期一";
        break;
      case "2":
        weekDay = "星期二";
        break;
      case "3":
        weekDay = "星期三";
        break;
      case "4":
        weekDay = "星期四";
        break;
      case "5":
        weekDay = "星期五";
        break;
      case "6":
        weekDay = "星期六";
        break;
      case "7":
        weekDay = "星期日";
        break;
    }
    return "${formatMonth(d1.month)}月${d1.day.toString()}日 $weekDay";
  }

  static String formatTimeToStr(int time) {
    DateTime dateTime = DateTime(time);
    return "${formatMonth(dateTime.month)}-${dateTime.day.toString()} ${dateTime.hour}:${dateTime.minute}";
  }

  static String formatMonth(int month) {
    if (month < 10) {
      return "0$month";
    } else {
      return month.toString();
    }
  }
}
