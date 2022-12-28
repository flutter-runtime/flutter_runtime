import 'package:flutter_runtime/src/analyzer/formal_parameter_analyzer.dart';

mixin MethodAnalyzerMixin {
  bool get isGetter;
  String get name;
  List<FormalParameterAnalyzer> get parameters;
}
