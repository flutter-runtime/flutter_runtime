import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/variable_analyzer.dart';

class FieldAnalyzer extends Analyzer<FieldDeclaration> {
  FieldAnalyzer(super.element);

  VariableAnalyzer get variable => VariableAnalyzer(element.fields.variables);

  bool get isFinal => element.fields.isFinal;
  bool get isConst => element.fields.isConst;
  bool get isStatic => element.isStatic;
}
