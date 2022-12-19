import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:flutter_runtime/src/analyzer/unit_analyzer.dart';
import 'package:path/path.dart' as p;

/// 分析库信息分析器
class RuntimeAnalyzer {
  RuntimeAnalyzer(this.rootPath);

  /// 分析库的工程路径
  final String rootPath;

  /// 对于库进行分析
  Future<void> analyze() async {
    final files = await analyzeFileList;

    /// 创建分析上下文组 用于分析缓存
    final contextCollection = AnalysisContextCollection(includedPaths: files);

    /// 对于文件分别进行单独分析
    for (final filePath in files) {
      print(filePath);

      /// 获取到关联分析的结果 getResolvedLibrary 这个方法分析有点慢
      final result = await contextCollection
          .contextFor(filePath)
          .currentSession
          .getResolvedLibrary(filePath);
      if (result is! ResolvedLibraryResult) {
        /// 如果不是 ResolvedLibraryResult 则继续
        continue;
      }
      for (final unit in result.units) {
        final unitAnalyzer = UnitAnalyzer(unit);
      }
    }
  }

  /// 分析的文件数组
  Future<List<String>> get analyzeFileList async {
    return Directory(rootPath).list(recursive: true).toList().then((value) {
      return value
          .whereType<File>()
          .where((element) => p.extension(element.path) == '.dart')
          .map((e) => e.path)
          .toList();
    });
  }
}
