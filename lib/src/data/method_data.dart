import 'package:flutter_runtime/src/data/data.dart';

class MethodData extends Data {
  MethodData(this.name, this.code);
  final String name;
  final String code;

  @override
  Map<String, dynamic> get toData {
    return {
      'name': name,
      'code': code,
    };
  }
}
