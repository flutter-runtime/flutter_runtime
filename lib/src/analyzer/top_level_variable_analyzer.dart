import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/variable_analyzer.dart';
import 'package:flutter_runtime/src/data/field_data.dart';

class TopLevelVariableAnalyzer extends Analyzer<TopLevelVariableDeclaration> {
  TopLevelVariableAnalyzer(super.element);

  VariableAnalyzer get variable {
    return VariableAnalyzer(element.variables.variables);
  }

  bool get isConst => element.variables.isConst;

  bool get isFinal => element.variables.isFinal;

  List<FieldData> get fieldDatas {
    return variable.names.map((e) {
      return FieldData(
        e,
        variable.typeName(withNullability: true)!,
        true,
        !isConst && !isFinal,
      );
    }).toList();
  }
}
