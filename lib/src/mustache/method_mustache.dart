final methodMustache = '''
{{{methodName}}}(
{{#parameters}}
{{#isNamed}}{{name}}:{{/isNamed}}parameters['{{name}}'] as {{{typeName}}},
{{/parameters}}
)
''';
