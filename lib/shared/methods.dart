String _getCurrentTime() {
  final DateTime now = DateTime.now();
  final String formattedDate = "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} "
      "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";
  return formattedDate;
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');