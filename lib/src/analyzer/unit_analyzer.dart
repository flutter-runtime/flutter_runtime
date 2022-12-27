import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_runtime/src/analyzer/analyzer.dart';
import 'package:flutter_runtime/src/analyzer/class_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/constructor_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/enum_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/extension_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/method_analyzer.dart';
import 'package:flutter_runtime/src/analyzer/top_level_variable_analyzer.dart';
import 'package:flutter_runtime/src/data/constructor_data.dart';
import 'package:flutter_runtime/src/data/field_data.dart';
import 'package:flutter_runtime/src/data/method_data.dart';
import 'package:flutter_runtime/src/data/parameter_data.dart';
import 'package:flutter_runtime/src/generator/enum_generator.dart';
import 'package:flutter_runtime/src/generator/method_generator.dart';
import 'package:flutter_runtime/src/generator/runtime_generator.dart';
import 'package:flutter_runtime/src/generator/variable_generator.dart';
import 'package:flutter_runtime/src/utils/utils.dart';

class UnitAnalyzer extends Analyzer<ResolvedUnitResult> {
  UnitAnalyzer(super.element, this.relativePath);

  /// 对应 Package 的相对路径
  final String relativePath;

  String get code {
    final nodes = element.unit.sortedDirectivesAndDeclarations;
    final codeBuffer = StringBuffer();

    final libraryRuntimeGenerator = RuntimeGenerator(
      runtimeName: 'Library',
      elementName: 'dynamic',
      relativePath: relativePath.substring(4),
      createCode: 'null',
      fields: nodes
          .whereType<TopLevelVariableDeclaration>()
          .map((e) => TopLevelVariableAnalyzer(e))
          .map((e) => e.fieldDatas)
          .fold<List<FieldData>>([], (previousValue, element) {
        return previousValue..addAll(element);
      }).where((element) {
        return !element.name.startsWith("_") &&
            !element.typeName.startsWith('_');
      }).toList(),
    );

    codeBuffer.writeln(libraryRuntimeGenerator.code);

    for (final node in nodes) {
      if (node is EnumDeclaration) {
        final analyzer = EnumAnalyzer(node);
        final generator = RuntimeGenerator(
          runtimeName: analyzer.name,
          relativePath: relativePath,
          elementName: analyzer.name,
          constructors: analyzer.cases.map((e) {
            return ConstructorData("'$e'", '${analyzer.name}.$e');
          }).toList(),
        );
        final code = generator.code;
        codeBuffer.writeln(code);
      } else if (node is TopLevelVariableDeclaration) {
        final analyzer = TopLevelVariableAnalyzer(node);
        // final code = VariableGenerator(analyzer.variable, relativePath).code;
        // codeBuffer.writeln(code);
      } else if (node is ClassDeclaration) {
        final analyzer = ClassAnalyzer(node);
        if (analyzer.name.startsWith("_")) continue;
        final generator = createRuntimeGeneratorFromClass(analyzer);
        final code = generator.code;
        codeBuffer.writeln(code);
      } else if (node is ExtensionDeclaration) {
        final analyzer = ExtensionAnalyzer(node);
        final generator = createRuntimeGeneratorFromExtension(analyzer);
        final code = generator.code;
        codeBuffer.writeln(code);
      } else {
        logger.e('${node.runtimeType.toString()} not supported');
      }
    }
    return '''
import 'package:flutter_runtime/flutter_runtime.dart';

${codeBuffer.toString()}
''';
  }

  RuntimeGenerator createRuntimeGeneratorFromClass(ClassAnalyzer analyzer) {
    return RuntimeGenerator(
      runtimeName: analyzer.name,
      relativePath: relativePath.substring(4),
      elementName: analyzer.name,
      constructors: analyzer.constructors.map((e) {
        final methodGenerator =
            createMethodGeneratorFromConstruct(e, analyzer.name);
        return ConstructorData(
          e.name == null ? 'null' : "'${e.name}'",
          methodGenerator.code,
        );
      }).toList(),
      fields: analyzer.fields.map(
        (e) {
          return e.variable.names.map((name) {
            return FieldData(
              name,
              e.variable.typeName(withNullability: true)!,
              true,
              !e.isFinal && !e.isConst,
              code: 'element.$name',
            );
          }).toList();
        },
      ).fold<List<FieldData>>([], (previousValue, element) {
        return previousValue..addAll(element);
      }).toList(),
    );
  }

  MethodGenerator createMethodGeneratorFromConstruct(
      ConstructorAnalyzer analyzer, String className) {
    late String name;
    if (analyzer.name == null) {
      name = className;
    } else {
      name = '$className.${analyzer.name}';
    }
    return MethodGenerator(
      name,
      analyzer.parameters.map((e) {
        return ParameterData(
          e.name!,
          e.type!.name(withNullability: true),
          e.isNamed,
          defaultValue: e.defaultValue,
          isOptional: e.isOptional,
        );
      }).toList(),
    );
  }

  RuntimeGenerator createRuntimeGeneratorFromExtension(
      ExtensionAnalyzer analyzer) {
    return RuntimeGenerator(
      runtimeName: analyzer.name!,
      relativePath: relativePath.substring(4),
      elementName: analyzer.extendedTypeName!,
      constructors: [],
      createCode: "parameters['element'] as ${analyzer.extendedTypeName!}",
      methods: analyzer.methods.map((e) {
        late String code;
        if (e.isGetter) {
          code = 'element.${e.name}';
        } else {
          code = createMethodGeneratorFromMethod(e).code;
        }
        return MethodData(e.name, code);
      }).toList(),
    );
  }

  MethodGenerator createMethodGeneratorFromMethod(MethodAnalyzer analyzer) {
    return MethodGenerator(
      analyzer.name,
      analyzer.parameters
          .map((e) => ParameterData(
                e.name!,
                e.type!.name(withNullability: true),
                e.isNamed,
                defaultValue: e.defaultValue,
                isOptional: e.isOptional,
              ))
          .toList(),
    );
  }
}
