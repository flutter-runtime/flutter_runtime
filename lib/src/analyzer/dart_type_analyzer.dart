import 'package:analyzer/dart/element/type.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';

class DartTypeAnalyzer extends Analyzer<DartType> {
  DartTypeAnalyzer(super.element);

  String name({required bool withNullability}) {
    return element.getDisplayString(withNullability: withNullability);
  }
}
