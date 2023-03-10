import 'package:flutter_runtime/src/data/data.dart';

class ParameterData extends Data {
  ParameterData(
    this.name,
    this.typeName,
    this.isNamed, {
    this.defaultValue,
    this.isOptional = false,
  });

  /// 参数的名称
  final String name;

  /// 参数的类型
  final String typeName;

  /// 参数是否是带名称参数
  final bool isNamed;

  /// 默认值
  final String? defaultValue;

  /// 是否是可选类型
  final bool isOptional;

  @override
  Map<String, dynamic> get toData {
    return {
      'name': name,
      'typeName': typeName,
      'isNamed': isNamed,
      'hasDefaultValue': defaultValue != null,
      'defaultValue': defaultValue,
      'isOptional': isOptional && defaultValue == null,
    };
  }
}
