import 'package:trreu/utils/ApiEndpoints.dart';

String getFullImageUrl(String? relativeUrl) {
  if (relativeUrl == null || relativeUrl.isEmpty) {
    return "";
  }
  if (relativeUrl.startsWith('http') || relativeUrl.startsWith('https')) {
    return relativeUrl;
  }

  // Else prepend base URL
  return ApiEndpoints.baseImageUrl + relativeUrl;
}
