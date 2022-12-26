import 'package:flutter_runtime/src/data/data.dart';

class FieldData extends Data {
  FieldData(
    this.name,
    this.typeName,
    this.isGetter,
    this.isSetter, {
    this.code,
  });

  /// 字段名称
  final String name;

  /// 字段类型
  final String typeName;

  /// 是否包含 Get 方法
  final bool isGetter;

  /// 是否包含 Set 方法
  final bool isSetter;

  /// Getter 值的代码
  final String? code;

  @override
  Map<String, dynamic> get toData {
    return {
      'name': name,
      'typeName': typeName,
      'isGetter': isGetter,
      'isSetter': isSetter,
      'code': code ?? name,
    };
  }
}
