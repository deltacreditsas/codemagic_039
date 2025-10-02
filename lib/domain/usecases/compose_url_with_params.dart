import '../../common/const/const_key.dart';

String _normalizeUrl(String input) {
  var value = input.trim();
  if (!value.startsWith(RegExp(r'https?://', caseSensitive: false))) {
    value = 'https://$value';
  }
  return value;
}

String _mergeQueryParams(
  String url,
  Map<String, String?> params, {
  bool overwrite = false,
}) {
  final normalized = _normalizeUrl(url);
  final uri = Uri.parse(normalized);

  final current = Map<String, String>.from(uri.queryParameters);

  String? findIgnoreCase(String key) {
    final target = key.toLowerCase();
    for (final existing in current.keys) {
      if (existing.toLowerCase() == target) return existing;
    }
    return null;
  }

  params.forEach((key, value) {
    if (value == null || value.isEmpty) return;

    final existingKey = findIgnoreCase(key);
    if (existingKey != null) {
      if (overwrite) {
        current.remove(existingKey);
        current[key] = value;
      }
    } else {
      current[key] = value;
    }
  });

  return uri.replace(queryParameters: current).toString();
}

Future<String> composeUrlWithParams(
  String url, {
  String? psht,
  String? luid,
  String? fbuid,
  bool overwrite = false,
}) async {
  return _mergeQueryParams(url, {
    if (psht != null && psht.isNotEmpty) ConstKey.kOne: psht,
    if (luid != null && luid.isNotEmpty) ConstKey.kTwo: luid,
    if (fbuid != null && fbuid.isNotEmpty) ConstKey.kThree: fbuid,
  }, overwrite: overwrite);
}
