extension StringExtension on String {
  String useCorrectEllipsis() {
    return replaceAll('', '\u200B');
  }
}
