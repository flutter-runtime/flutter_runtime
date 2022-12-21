import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/enum_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/top_level_variable_analyzer.dart';
import 'package:flutter_runtime/src/generator/enum_generator.dart';
import 'package:flutter_runtime/src/generator/top_level_variable_generator.dart';
import 'package:flutter_runtime/src/utils/utils.dart';

class UnitAnalyzer extends Analyzer<ResolvedUnitResult> {
  UnitAnalyzer(super.element);

  String get code {
    final nodes = element.unit.sortedDirectivesAndDeclarations;
    final codeBuffer = StringBuffer();
    for (final node in nodes) {
      if (node is EnumDeclaration) {
        final analyzer = EnumAnalyzer(node);
        final code = EnumGenerator(analyzer).code;
        codeBuffer.writeln(code);
      } else if (node is TopLevelVariableDeclaration) {
        final analyzer = TopLevelVariableAnalyzer(node);
        final code = TopLevelVariableGenerator(analyzer).code;
        codeBuffer.writeln(code);
      } else {
        logger.e('${node.runtimeType.toString()} not supported');
      }
    }
    return '''
import 'package:flutter_runtime/flutter_runtime.dart';

${codeBuffer.toString()}
''';
  }
}
