final topLevelVariableMustache = '''
{{#topLevelVariables}}
{{{typeName}}} get \${{name}}\$ => {{name}};
{{#hasSet}}

void \${{setMethodName}}\$({{{typeName}}} value) => {{name}} = value;
{{/hasSet}}
{{/topLevelVariables}}
''';
