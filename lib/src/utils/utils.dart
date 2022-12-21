import 'package:logger/logger.dart';

final logger = Logger();

extension StringToHump on String {
  String toHump() {
    final first = substring(0, 1);
    return first.toUpperCase() + first.substring(1);
  }
}
