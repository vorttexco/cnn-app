extension StringExtension on String {
  String get hour => _getHour();

  String stripHtml() {
    return replaceAll(RegExp(r'<[^>]*>'), '').replaceAll(RegExp(r'&[a-zA-Z0-9#=]+;'), '');
  }

  _getHour() {
    return '${substring(0, 2)}h';
  }
}
