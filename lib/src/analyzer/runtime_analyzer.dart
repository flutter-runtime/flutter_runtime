import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter_runtime/src/analyzer/unit_analyzer.dart';
import 'package:flutter_runtime/src/utils/utils.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/shell.dart';
import 'package:pubspec/pubspec.dart';

/// 分析库信息分析器
class RuntimeAnalyzer {
  RuntimeAnalyzer(this.rootPath);

  /// 分析库的工程路径
  final String rootPath;

  /// 对于库进行分析
  Future<void> analyze() async {
    final depsJson = await loadDeps();

    final pubspec = await PubSpec.load(Directory(rootPath));
    await createEmptyRuntimePackage(pubspec);

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
        final relativePath = p.relative(filePath, from: rootPath);
        final analyzer = UnitAnalyzer(unit, relativePath);
        final code = analyzer.code;
        final path = p.join(
          packagePath(packageName(pubspec)),
          relativePath,
        );

        final formatCode = DartFormatter().format('''
// ignore_for_file: implementation_imports, depend_on_referenced_packages, unused_import, curly_braces_in_flow_control_structures

import 'package:${pubspec.name}/${relativePath.replaceAll('lib/', '')}';
$code
''');

        await createFile(formatCode, path);

        logger.i('$path 生成成功!');
      }
    }
    await runPubGet(packagePath(packageName(pubspec)));
  }

  Future<void> createEmptyRuntimePackage(PubSpec spec) async {
    final packageName = this.packageName(spec);
    final packagePath = this.packagePath(packageName);
    if (await Directory(packagePath).exists()) {
      await Directory(packagePath).delete(recursive: true);
    }

    await createFile(
      '''
name: ${spec.name}_runtime
version: 1.0.0

environment:
  sdk: '>=2.18.5 <3.0.0'

dev_dependencies:
  lints: ^2.0.0
dependencies:
  flutter_runtime:
    path: ${Platform.environment['PWD']!}

dependency_overrides:
  ${spec.name}:
    path: $rootPath
  
''',
      p.join(packagePath, 'pubspec.yaml'),
    );

    await createFile(
      '''
include: package:lints/recommended.yaml
''',
      p.join(packagePath, 'analysis_options.yaml'),
    );

    await createFile(
      '''
library ${spec.name}_runtime;
''',
      p.join(packagePath, 'lib', '${spec.name}_runtime.dart'),
    );
  }

  Future<void> createFile(String content, String path) async {
    final file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(content);
  }

  /// 分析的文件数组
  Future<List<String>> get analyzeFileList async {
    return Directory(p.join(rootPath, 'lib'))
        .list(recursive: true)
        .toList()
        .then((value) {
      return value
          .whereType<File>()
          .where((element) => p.extension(element.path) == '.dart')
          .where((element) => !element.path.endsWith('.r.dart'))
          .map((e) => e.path)
          .toList();
    });
  }

  String get runtimeCacheDir {
    return p.join(
      Platform.environment['HOME']!,
      '.runtime',
    );
  }

  String packagePath(String packageName) =>
      p.join(runtimeCacheDir, packageName);

  String packageName(PubSpec spec) => '${spec.name}_${spec.version}';

  Future<void> runPubGet(String root) async {
    final flutter = await which('flutter');
    final results = await Shell(workingDirectory: root).run('''
$flutter pub get
''');
    final errTexts = results.map((e) => e.errText);
    if (errTexts.isEmpty) {
      logger.e(errTexts.join('\n'));
      exitCode = 1;
    }
  }

  Future<String> loadDeps() async {
    final flutter = await which('flutter');
    final results = await Shell(workingDirectory: rootPath).run('''
$flutter pub deps --json
''');
    return results.first.outText;
  }
}
