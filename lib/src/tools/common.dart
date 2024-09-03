bool valueIsEmpty<T>(T value) {
  if (value == null) {
    return true;
  }

  if (value is String) {
    return value.isEmpty || value == "null";
  }

  if (value is List) {
    return value.isEmpty;
  }

  if (value is Set) {
    return value.isEmpty;
  }

  if (value is Map) {
    return value.isEmpty;
  }

  return false;
}

///给一个url追加参数
String setUrlParams(String baseUrl, Map<String, dynamic> params) {
  if (params.isEmpty) return baseUrl;

  final buffer = StringBuffer(baseUrl);
  if (!baseUrl.contains("?")) {
    buffer.write("?");
  } else if (!baseUrl.endsWith("&") && !baseUrl.endsWith("?")) {
    buffer.write("&");
  }

  params.forEach((key, value) {
    buffer.write("${Uri.encodeComponent(key)}=${Uri.encodeComponent(value.toString())}&");
  });

  String urlWithParams = buffer.toString();
  // 移除最后一个多余的"&"
  if (urlWithParams.endsWith("&")) {
    urlWithParams = urlWithParams.substring(0, urlWithParams.length - 1);
  }

  return urlWithParams;
}