import 'package:intl/intl.dart';

String getCurrentTime() {
  final DateTime now = DateTime.now();
  final String formattedDate = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} "
      "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";
  return formattedDate;
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}