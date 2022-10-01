import 'package:intl/intl.dart';

String readTimestamp(String timestamp) {
  var format = DateFormat('dd MMMM yyyy');
  var date = DateTime.parse(timestamp);
  var time = '';
  time = format.format(date);

  return time;
}
