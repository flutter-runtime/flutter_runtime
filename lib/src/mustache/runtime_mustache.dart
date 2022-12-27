final runtimeMustache = '''
class \${{runtimeName}}\$ extends Runtime{{#hasElementName}}<{{elementName}}>{{/hasElementName}} {
  \${{runtimeName}}\$(super.parameters);

  @override
  String get relativePath => '{{{relativePath}}}';

  @override
  create() {
    {{#hasConstructors}}
    final constructorName = parameters['constructorName'] as String?;
    {{#constructors}}
    if (constructorName == {{{name}}}) return {{{code}}};
    {{/constructors}}
    throw UnimplementedError();
    {{/hasConstructors}}
    {{^hasConstructors}}
    return {{{createCode}}};
    {{/hasConstructors}}
  }

  @override
  operator [](String name) {
    {{#hasGetterFields}}
    {{#fields}}
    if (name == '{{name}}') return {{code}};
    {{/fields}}
    {{/hasGetterFields}}
    throw UnsupportedError(name);
  }

  @override
  call(String name, Map<String, dynamic> data) {
    {{#hasMethods}}
    {{#methods}}
    if (name == '{{name}}') return {{{code}}};
    {{/methods}}
    {{/hasMethods}}
    throw UnimplementedError();
  }
}
''';
