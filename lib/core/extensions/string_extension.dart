extension StringExtension on String {
  String get hour => _getHour();

  _getHour() {
    return '${substring(0, 2)}h';
  }
}
