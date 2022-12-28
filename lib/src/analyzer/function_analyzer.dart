import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/formal_parameter_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/method_analyzer_mixin.dart';

class FunctionAnalyzer extends Analyzer<FunctionDeclaration>
    with MethodAnalyzerMixin {
  FunctionAnalyzer(super.element);

  @override
  bool get isGetter => element.isGetter;

  @override
  String get name => element.name.lexeme;

  @override
  List<FormalParameterAnalyzer> get parameters =>
      element.functionExpression.parameters?.parameters
          .map((e) => FormalParameterAnalyzer(e))
          .toList() ??
      [];
}
