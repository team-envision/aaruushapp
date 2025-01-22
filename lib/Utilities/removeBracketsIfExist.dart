
String toRemoveTextInBracketsIfExists(String input) {
    if (input.contains(RegExp(r'\(.*?\)'))) {
      return input.replaceAll(RegExp(r'\s*\(.*?\)\s*'), '').split(' ').first;
    }
    return input.split(' ').first;
  }


