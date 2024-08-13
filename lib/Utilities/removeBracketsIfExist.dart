
String toRemoveTextInBracketsIfExists(String input) {
    if (input.contains(RegExp(r'\(.*?\)'))) {
      return input.replaceAll(RegExp(r'\s*\(.*?\)\s*'), '');
    }
    return input;
  }


