import 'package:analyzer/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/dart_type_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/method_analyzer.dart';

class ExtensionAnalyzer extends Analyzer<ExtensionDeclaration> {
  ExtensionAnalyzer(super.element);

  /// 扩展的名称
  String? get name => element.name?.lexeme;

  /// 扩展类型名称
  String? get extendedTypeName {
    return Unwrap(element.extendedType.type)
        .map((e) => DartTypeAnalyzer(e).name(withNullability: true))
        .value;
  }

  List<MethodAnalyzer> get methods => element.members
      .whereType<MethodDeclaration>()
      .map((e) => MethodAnalyzer(e))
      .toList();
}
