import 'dart:convert';

Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

Map<String, dynamic> parseJwtHeader(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[0]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

//String

void main() {
  String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZW5hbnRAdGhpbmdzYm9hcmQub3JnIiwic2NvcGVzIjpbIlRFTkFOVF9BRE1JTiJdLCJ1c2VySWQiOiJkY2MzYjNjMC04ZGE3LTExZWItYTAxMC02ZDllNmI2MTJhOTAiLCJlbmFibGVkIjp0cnVlLCJpc1B1YmxpYyI6ZmFsc2UsInRlbmFudElkIjoiZGJmMDVlMzAtOGRhNy0xMWViLWEwMTAtNmQ5ZTZiNjEyYTkwIiwiY3VzdG9tZXJJZCI6IjEzODE0MDAwLTFkZDItMTFiMi04MDgwLTgwODA4MDgwODA4MCIsImlzcyI6InRoaW5nc2JvYXJkLmlvIiwiaWF0IjoxNjE4OTk5MTY0LCJleHAiOjE2MTkwODU1NjR9.2BFimKGyDE1d0lCNph4JCO-l7p797yyZ7xeddk7yrluYPv2CODwDBTZwbPGBF-sYJiEKkC4mOk-duJGw3bZ3VQ";
  print('token');
  print(DateTime.fromMillisecondsSinceEpoch(
      parseJwtPayLoad(token)["iat"] * 1000));
  print(DateTime.fromMillisecondsSinceEpoch(
      parseJwtPayLoad(token)["exp"] * 1000));
  print(parseJwtPayLoad(token)["exp"]);
  // print(DateTime.now().millisecondsSinceEpoch);
}
