import 'package:flutter_runtime/src/analyzer/runtime_analyzer.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

Future<void> main(List<String> args) async {
  final runtimeAnalyzer = RuntimeAnalyzer(
    p.join(Platform.environment['PWD']!, args.first),
  );
  await runtimeAnalyzer.analyze();
}
