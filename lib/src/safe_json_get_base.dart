typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension JsonObjectX on JsonObject {
  int? getInt(String key, [int? defaultValue]) {
    return switch (this[key]) {
      int value => value,
      num value => value.toInt(),
      dynamic value => value == null ? defaultValue : int.tryParse('$value'),
    };
  }

  double? getDouble(String key, [double? defaultValue]) {
    return switch (this[key]) {
      double value => value,
      num value => value.toDouble(),
      dynamic value => value == null ? defaultValue : double.tryParse('$value'),
    };
  }

  String? getString(String key, [String? defaultValue]) => switch (this[key]) {
        String value => value,
        dynamic value => value?.toString() ?? defaultValue,
      };

  bool? getBool(String key, [bool? defaultValue]) => switch (this[key]) {
        bool value => value,
        dynamic value =>
          bool.tryParse('$value', caseSensitive: false) ?? defaultValue,
      };

  List<R>? getList<R>(String key, [List<R>? defaultValue]) =>
      switch (this[key]) {
        List<R> value => value,
        List value => value.whereType<R>().toList().cast<R>(),
        _ => defaultValue,
      };

  JsonObject? getJson(String key, [JsonObject? defaultValue]) =>
      switch (this[key]) {
        JsonObject value => value,
        Map value => value.map((key, value) => MapEntry('$key', value)),
        _ => defaultValue,
      };

  bool isJson(String key) => switch (this[key]) {
        JsonObject _ => true,
        _ => false,
      };

  bool isArray(String key) => switch (this[key]) {
        JsonArray _ => true,
        _ => false,
      };
}
