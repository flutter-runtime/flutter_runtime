import 'package:analyzer/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/formal_parameter_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/method_analyzer_mixin.dart';

class MethodAnalyzer extends Analyzer<MethodDeclaration>
    with MethodAnalyzerMixin {
  MethodAnalyzer(super.element);

  /// 方法名称
  @override
  String get name => element.name.lexeme;

  /// 方法参数
  @override
  List<FormalParameterAnalyzer> get parameters {
    return Unwrap(element.parameters)
        .map((e) => e.parameters)
        .map((e) => e.map((e) => FormalParameterAnalyzer(e)).toList())
        .defaultValue([]);
  }

  @override
  bool get isGetter => element.isGetter;
}
