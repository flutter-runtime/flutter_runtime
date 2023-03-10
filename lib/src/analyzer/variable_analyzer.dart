import 'package:analyzer/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/dart_type_analyzer.dart';

class VariableAnalyzer extends Analyzer<NodeList<VariableDeclaration>> {
  VariableAnalyzer(super.element);

  /// 变量名称数组 比如一行 int a,b;
  List<String> get names {
    return element.map((e) => e.name.lexeme).toList();
  }

  /// 获取类型的名称
  String? typeName({required bool withNullability}) {
    return Unwrap(element.first.declaredElement?.type).map((e) {
      return DartTypeAnalyzer(e).name(withNullability: withNullability);
    }).value;
  }

  String? defaultValueCode(String name) {
    final index = element.indexWhere((element) => element.name.lexeme == name);
    if (index == -1) return null;
    return element[index].initializer?.staticParameterElement?.defaultValueCode;
  }
}
