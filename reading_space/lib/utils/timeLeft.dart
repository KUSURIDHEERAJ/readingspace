class OurTimeLeft {
  List<String> timeLeft(DateTime due) {
    List<String> returnVal = List(2);
    Duration timeUntilDue = due.difference(DateTime.now());
    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil =
        timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);
    int secUntil = timeUntilDue.inSeconds -
        (daysUntil * 24 * 60 * 60) -
        (hoursUntil * 60 * 60) -
        (minUntil * 60);
    returnVal[0] = daysUntil.toString();
    returnVal[1] = "value 2";
    return returnVal;
  }
}
