final variableMustache = '''
{{#topLevelVariables}}
{{{typeName}}} get \${{name}}\$ => {{value}};
{{#hasSet}}

void \${{setMethodName}}\$({{{typeName}}} value) => {{name}} = value;
{{/hasSet}}
{{/topLevelVariables}}
''';
