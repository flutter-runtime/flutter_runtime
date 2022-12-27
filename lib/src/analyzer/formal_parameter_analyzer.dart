import 'package:analyzer/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/dart_type_analyzer.dart';

class FormalParameterAnalyzer extends Analyzer<FormalParameter> {
  FormalParameterAnalyzer(super.element);

  /// 参数名称
  String? get name => element.name?.lexeme;

  /// 是否是有名称的参数
  bool get isNamed => element.isNamed;

  /// 默认初始化值
  String? get defaultValue => element.declaredElement?.defaultValueCode;

  /// 类型解析器
  DartTypeAnalyzer? get type {
    return Unwrap(element.declaredElement?.type)
        .map((e) => DartTypeAnalyzer(e))
        .value;
  }

  bool get isOptional => element.isOptional;
}
