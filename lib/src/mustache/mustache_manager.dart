import 'package:mustache_template/mustache.dart';

class MustacheManager {
  MustacheManager({
    required this.mustacheContent,
    required this.data,
    this.dependencies = const {},
  });
  final String mustacheContent;
  final Map<String, dynamic> data;
  final Map<String, Template> dependencies;

  String get code {
    final template = Template(
      mustacheContent,
      partialResolver: (name) {
        return dependencies[name];
      },
    );
    return template.renderString(data);
  }
}
