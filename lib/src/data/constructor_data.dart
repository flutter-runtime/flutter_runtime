import 'package:flutter_runtime/src/data/data.dart';

class ConstructorData extends Data {
  ConstructorData(this.name, this.code);

  /// 构造器名字
  final String name;

  /// 构造器代码
  final String code;

  @override
  Map<String, dynamic> get toData {
    return {
      'name': name,
      'code': code,
    };
  }
}
