import 'dart:core';

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension JsonObjectX on JsonObject {
  int? valInt(String key, {int? defaultValue}) {
    return switch (this[key]) {
      int value => value,
      num value => value.toInt(),
      dynamic value => value == null ? defaultValue : int.tryParse('$value'),
    };
  }

  double? valDouble(String key, {double? defaultValue}) {
    return switch (this[key]) {
      double value => value,
      num value => value.toDouble(),
      dynamic value => value == null ? defaultValue : double.tryParse('$value'),
    };
  }

  String? valString(String key, {String? defaultValue}) => switch (this[key]) {
        String value => value,
        dynamic value => value?.toString() ?? defaultValue,
      };

  bool? valBool(String key, {bool? defaultValue}) => switch (this[key]) {
        bool value => value,
        dynamic value =>
          bool.tryParse('$value', caseSensitive: false) ?? defaultValue,
      };

  List<R>? valList<R>(String key, {List<R>? defaultValue}) =>
      switch (this[key]) {
        List<R> value => value,
        List value => value.whereType<R>().toList().cast<R>(),
        _ => defaultValue,
      };

  JsonObject? valJson(String key, {JsonObject? defaultValue}) =>
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

  int getInt(String key, {int defaultValue = 0}) =>
      valInt(key, defaultValue: defaultValue)!;

  double getDouble(String key, {double defaultValue = .0}) =>
      valDouble(key, defaultValue: defaultValue)!;

  String getString(String key, {String defaultValue = ''}) =>
      valString(key, defaultValue: defaultValue)!;

  bool getBool(String key, {bool defaultValue = false}) =>
      valBool(key, defaultValue: defaultValue)!;

  List<R> getList<R>(String key, {List<R> defaultValue = const []}) =>
      valList(key, defaultValue: defaultValue)!;

  JsonObject getJson(String key, {JsonObject defaultValue = const {}}) =>
      valJson(key, defaultValue: defaultValue)!;
}
