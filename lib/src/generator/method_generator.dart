import 'package:flutter_runtime/src/data/data.dart';
import 'package:flutter_runtime/src/data/parameter_data.dart';
import 'package:flutter_runtime/src/mustache/method_mustache.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';

class MethodGenerator extends Data {
  MethodGenerator(this.name, this.parameters);

  /// 方法名称
  final String name;

  /// 方法参数
  final List<ParameterData> parameters;

  String get code {
    return MustacheManager(content: methodMustache, data: this).code;
  }

  @override
  Map<String, dynamic> get toData {
    return {
      'methodName': name,
      'parameters': parameters.map((e) => e.toData).toList(),
    };
  }
}
