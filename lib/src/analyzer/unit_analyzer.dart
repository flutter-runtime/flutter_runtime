import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/enum_analyzer.dart';

class UnitAnalyzer extends Analyzer<ResolvedUnitResult> {
  UnitAnalyzer(super.element) {
    final nodes = element.unit.sortedDirectivesAndDeclarations;
    for (final node in nodes) {
      if (node is EnumDeclaration) {
        final enumAnalyzer = EnumAnalyzer(node);
      } else {
        throw UnsupportedError(node.runtimeType.toString());
      }
    }
  }
}
