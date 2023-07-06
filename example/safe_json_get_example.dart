import 'package:safe_json_get/safe_json_get.dart';

void main() {
  var map = {"a": 2.0, "b": false};
  print(map.getInt("a"));
}
