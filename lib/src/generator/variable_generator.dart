import 'package:flutter_runtime/src/analyzer/variable_analyzer.dart';
import 'package:flutter_runtime/src/data/variable_data.dart';
import 'package:flutter_runtime/src/generator/generator.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';
import 'package:flutter_runtime/src/mustache/variable_mustache.dart';
import 'package:flutter_runtime/src/utils/utils.dart';

class VariableGenerator extends Generator<VariableAnalyzer> {
  VariableGenerator(super.analyzer, super.relativePath, {this.value});

  final String Function(String name)? value;

  @override
  MustacheManager get manager {
    return MustacheManager(
      content: variableMustache,
      data: VariableData(),
    );
  }
}
