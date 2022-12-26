import 'package:flutter_runtime/src/data/constructor_data.dart';
import 'package:flutter_runtime/src/data/data.dart';

class ClassData extends Data {
  ClassData(
    this.name,
    this.constructors,
  );

  /// 类名
  final String name;

  /// 构造函数
  final List<ConstructorData> constructors;

  @override
  Map<String, dynamic> get toData {
    return {
      'name': name,
      'constructors': constructors.map((e) => e.toData).toList(),
    };
  }
}
