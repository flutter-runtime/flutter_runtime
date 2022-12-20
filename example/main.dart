import 'package:flutter_runtime/src/analyzer/runtime_analyzer.dart';

Future<void> main(List<String> args) async {
  final runtimeAnalyzer = RuntimeAnalyzer(args.first);
  await runtimeAnalyzer.analyze();
}
