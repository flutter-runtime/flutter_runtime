final classMustache = '''
class \${{className}}\$ extends Runtime<{{className}}> {
  \${{className}}\$(super.parameters);

  @override
  {{className}} create() {
    final constructorName = parameters['constructorName'] as String?;
    {{#constructors}}
    if (constructorName == {{{name}}}) {
      return {{{code}}};
    }
    {{/constructors}}
    throw UnimplementedError();
  }
}
''';
