import 'dart:convert';

class ParseToModelInterface<T> {
  final String res;
  final T Function(Map<String, dynamic>) fromJson;

  ParseToModelInterface(this.res, this.fromJson);
}

T parseJson<T>(ParseToModelInterface<T> json) {
  final Map<String, dynamic> parsed = jsonDecode(json.res);

  return json.fromJson(parsed);
}
