import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/expression_analyzer.dart';

class EnumAnalyzer extends Analyzer<EnumDeclaration> {
  EnumAnalyzer(super.element) {
    print(name);
    print(isOldVersion);
    print(values);
  }

  /// 获取枚举的名称
  String get name => element.name.lexeme;

  /// 是否是旧版本
  bool get isOldVersion => element.members.isEmpty;

  /// 枚举的值
  List<EnumValue> get values {
    return element.constants.map<EnumValue>((e) {
      if (element.members.isEmpty) {
        return EnumStringValue(e.name.lexeme);
      } else {
        final map = <String, dynamic>{};
        final arguments = e.arguments?.argumentList.arguments;

        /// 先获取到初始化函数的默认值
        final constructor =
            element.members.whereType<ConstructorDeclaration>().first;
        for (final parameter in constructor.parameters.parameterElements) {
          final defaultValueCode = parameter?.defaultValueCode;
          final name = parameter?.name;
          if (defaultValueCode != null && name != null) {
            map[name] = defaultValueCode;
          }
        }

        if (arguments != null) {
          for (final argument in arguments) {
            final expressAnalyzer = ExpressionAnalyzer(argument);
            final name = expressAnalyzer.name;
            final value = expressAnalyzer.value;
            map[name!] = value;
          }
        }
        return EnumObjectValue(e.name.lexeme, map);
      }
    }).toList();
  }
}

/// 枚举的值
abstract class EnumValue<T> {
  EnumValue(this.value);
  final T value;
}

class EnumStringValue extends EnumValue<String> {
  EnumStringValue(super.value);
}

class EnumObjectValue extends EnumValue<Map<String, dynamic>> {
  EnumObjectValue(this.name, super.value);
  final String name;
}
