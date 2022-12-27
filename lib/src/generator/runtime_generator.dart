import 'package:flutter_runtime/src/data/constructor_data.dart';
import 'package:flutter_runtime/src/data/data.dart';
import 'package:flutter_runtime/src/data/field_data.dart';
import 'package:flutter_runtime/src/data/method_data.dart';
import 'package:flutter_runtime/src/mustache/mustache_manager.dart';
import 'package:flutter_runtime/src/mustache/runtime_mustache.dart';

class RuntimeGenerator extends Data {
  RuntimeGenerator({
    required this.runtimeName,
    required this.relativePath,
    this.elementName,
    this.constructors = const [],
    this.fields = const [],
    this.methods = const [],
    this.createCode,
  });

  final String runtimeName;
  final String? elementName;
  final String relativePath;
  final List<ConstructorData> constructors;
  final List<FieldData> fields;
  final List<MethodData> methods;
  final String? createCode;

  String get code {
    return MustacheManager<RuntimeGenerator>(
      content: runtimeMustache,
      data: this,
    ).code;
  }

  @override
  Map<String, dynamic> get toData => {
        'runtimeName': runtimeName,
        'relativePath': relativePath,
        'elementName': elementName,
        'hasElementName': elementName != null,
        'constructors': constructors.map((e) => e.toData).toList(),
        'hasConstructors': constructors.isNotEmpty,
        'fields': fields.map((e) => e.toData).toList(),
        'hasGetterFields': fields.map((e) => e.isGetter).isNotEmpty,
        'methods': methods.map((e) => e.toData).toList(),
        'hasMethods': methods.isNotEmpty,
        'createCode': createCode,
      };
}
