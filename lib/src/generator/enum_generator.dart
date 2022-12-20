import 'package:flutter_runtime/src/analyzer/enum_analyzer.dart';
import 'package:flutter_runtime/src/generator/generator.dart';
import 'package:flutter_runtime/src/mustache/enum_mustache.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';

class EnumGenerator extends Generator<EnumAnalyzer> {
  EnumGenerator(super.analyzer);

  @override
  MustacheManager get manager {
    return MustacheManager(
      mustacheContent: enumMustache,
      data: {
        'enumName': analyzer.name,
        'cases': analyzer.cases.map((e) => {'name': e}).toList(),
      },
    );
  }
}
