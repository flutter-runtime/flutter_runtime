const enumMustache = '''
class \${{{enumName}}}\$ extends Runtime<{{{enumName}}}> {
  \${{{enumName}}}\$(super.parameters);

  @override
  {{{enumName}}} create() {
    final caseName = parameters['caseName'] as String;
    {{#cases}}
    if (caseName == '{{name}}') return {{{enumName}}}.{{name}};
    {{/cases}}
    throw UnsupportedError(caseName);
  }
}
''';
