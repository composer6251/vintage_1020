
String? extractDistinctUrl(String fullString, String? searchString) {
  final defaultDistinctImageUrl = 'image_picker_';
  final searchStringToUse = searchString ?? defaultDistinctImageUrl;
  int startIndex = fullString.indexOf(searchStringToUse);

  if (startIndex != -1) {
    String subStringAfter = fullString.substring(startIndex + searchStringToUse.length);
    print(subStringAfter); // Output: this is a test string.
    return subStringAfter;
  }
  return null;
}
