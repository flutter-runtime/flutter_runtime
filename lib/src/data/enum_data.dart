import 'package:flutter_runtime/src/data/data.dart';

class EnumData extends Data {
  EnumData(this.name, this.caseNames);

  /// Enum 名字
  final String name;

  /// Case的名称数组
  final List<String> caseNames;

  @override
  Map<String, dynamic> get toData {
    return {
      'enumName': name,
      'cases': caseNames.map((e) => {'name': e}).toList(),
    };
  }
}
