final methodMustache = '''
{{{methodName}}}(
{{#parameters}}
{{#isNamed}}{{name}}:{{/isNamed}}parameters.get('{{name}}'{{#hasDefaultValue}},{{{defaultValue}}}{{/hasDefaultValue}}){{^isOptional}}!{{/isOptional}},
{{/parameters}}
)
''';
