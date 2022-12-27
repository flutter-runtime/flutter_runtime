import 'package:analyzer/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/formal_parameter_analyzer.dart';

class MethodAnalyzer extends Analyzer<MethodDeclaration> {
  MethodAnalyzer(super.element);

  /// 方法名称
  String get name => element.name.lexeme;

  /// 方法参数
  List<FormalParameterAnalyzer> get parameters {
    return Unwrap(element.parameters)
        .map((e) => e.parameters)
        .map((e) => e.map((e) => FormalParameterAnalyzer(e)).toList())
        .defaultValue([]);
  }

  bool get isGetter => element.isGetter;
}
