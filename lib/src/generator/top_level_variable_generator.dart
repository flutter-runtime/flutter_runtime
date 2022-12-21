import 'package:flutter_runtime/src/analyzer/top_level_variable_analyzer.dart';
import 'package:flutter_runtime/src/generator/generator.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';
import 'package:flutter_runtime/src/mustache/top_level_variable_mustache.dart';
import 'package:flutter_runtime/src/utils/utils.dart';

class TopLevelVariableGenerator extends Generator<TopLevelVariableAnalyzer> {
  TopLevelVariableGenerator(super.analyzer);

  @override
  MustacheManager get manager {
    return MustacheManager(
      mustacheContent: topLevelVariableMustache,
      data: {
        'topLevelVariables': analyzer.names.map((e) {
          return {
            'typeName': analyzer.typeName(withNullability: true)!,
            'name': e,
            'hasSet': !analyzer.isConst,
            'setMethodName': 'set${e.toHump()}',
          };
        }).where((element) {
          final typeName = element['typeName'] as String;
          return !typeName.startsWith("_");
        }).toList(),
      },
    );
  }
}
