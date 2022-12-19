import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';

class ExpressionAnalyzer extends Analyzer<Expression> {
  ExpressionAnalyzer(super.element);

  String? get name => element.staticParameterElement?.name;

  String get value {
    if (element is SimpleStringLiteral) {
      return (element as SimpleStringLiteral).value;
    } else {
      throw UnsupportedError(element.runtimeType.toString());
    }
  }
}
