import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/constructor_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/field_analyzer.dart';
import 'package:flutter_runtime/src/utils/utils.dart';

class ClassAnalyzer extends Analyzer<ClassDeclaration> {
  ClassAnalyzer(super.element) {
    logger.v(constructors);
  }

  /// 类的名称
  String get name => element.name.lexeme;

  /// 字段分析器列表
  List<FieldAnalyzer> get fields {
    return element.members
        .whereType<FieldDeclaration>()
        .map((e) => FieldAnalyzer(e))
        .toList();
  }

  /// 构造方法分析器列表
  List<ConstructorAnalyzer> get constructors {
    return element.members
        .whereType<ConstructorDeclaration>()
        .map((e) => ConstructorAnalyzer(e))
        .toList();
  }
}
