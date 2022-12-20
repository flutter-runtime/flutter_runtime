import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';

class EnumAnalyzer extends Analyzer<EnumDeclaration> {
  EnumAnalyzer(super.element);

  /// 获取枚举的名称
  String get name => element.name.lexeme;

  /// 是否是旧版本
  bool get isOldVersion => element.members.isEmpty;

  /// 枚举的值
  List<String> get cases {
    return element.constants.map((e) => e.name.lexeme).toList();
  }
}
