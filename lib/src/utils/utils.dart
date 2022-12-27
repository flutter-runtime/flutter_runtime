import 'package:logger/logger.dart';

final logger = Logger();

extension StringToHump on String {
  String toHump() {
    final first = substring(0, 1);
    return first.toUpperCase() + first.substring(1);
  }
}

extension $RuntimeCreate on Map<String, dynamic> {
  T? get<T>(String name, [T? defaultValue]) {
    final value = this[name];
    if (value == null) return defaultValue;
    return value as T;
  }
}
