import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';

abstract class Generator<T extends Analyzer> {
  Generator(this.analyzer);

  /// 对应的分析器
  final T analyzer;

  /// 生成的代码
  String get code => manager.code;

  /// Mustache 管理器
  MustacheManager get manager;
}
