import 'package:flutter_runtime/src/data/data.dart';
import 'package:mustache_template/mustache.dart';

class MustacheManager<T extends Data> {
  MustacheManager({
    required this.content,
    required this.data,
    this.dependencies = const {},
  });
  final String content;
  final T data;
  final Map<String, Template> dependencies;

  String get code {
    final template = Template(
      content,
      partialResolver: (name) {
        return dependencies[name];
      },
    );
    return template.renderString(data.toData);
  }
}
