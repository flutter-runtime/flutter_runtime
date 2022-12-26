import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/formal_parameter_analyzer.dart';

class ConstructorAnalyzer extends Analyzer<ConstructorDeclaration> {
  ConstructorAnalyzer(super.element) {
    print(name);
  }

  /// 构造器的名称
  String? get name => element.name?.lexeme;

  /// 构造器的参数
  List<FormalParameterAnalyzer> get parameters {
    return element.parameters.parameters
        .map((e) => FormalParameterAnalyzer(e))
        .toList();
  }
}
