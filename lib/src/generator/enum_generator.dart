import 'package:flutter_runtime/src/analyzer/enum_analyzer.dart';
import 'package:flutter_runtime/src/data/enum_data.dart';
import 'package:flutter_runtime/src/generator/generator.dart';
import 'package:flutter_runtime/src/mustache/enum_mustache.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';

class EnumGenerator extends Generator<EnumAnalyzer> {
  EnumGenerator(super.analyzer, super.relativePath);

  @override
  MustacheManager get manager {
    return MustacheManager(
      content: enumMustache,
      data: EnumData(analyzer.name, analyzer.cases),
    );
  }
}
