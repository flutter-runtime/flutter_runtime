import 'package:flutter_runtime/flutter_runtime.dart';

/// 所有的运行时注册器都必须要要实现这个接口
abstract class FlutterRuntime<T> {
  /// 当前运行时对象
  final T runtime;
  FlutterRuntime(this.runtime);

  /// 获取当前运行时公开只读的属性
  /// [callPath] 运行时调用的路径
  /// [fieldName] 属性的名称
  dynamic getField(
    FlutterRuntimeCallPath callPath,
    String fieldName,
  );

  /// 设置当前运行时公开只读的属性
  /// [callPath] 运行时调用的路径
  /// [fieldName] 属性的名称
  /// [value] 属性的值
  void setField(
    FlutterRuntimeCallPath callPath,
    String fieldName,
    dynamic value,
  );

  /// 执行当前类的公开方法
  /// [callPath] 运行时调用的路径
  /// [methodName] 方法名称
  /// [args] 方法的参数
  dynamic call(
    FlutterRuntimeCallPath callPath,
    String methodName, [
    Map args = const {},
  ]);

  /// 创建当前运行时实例对象
  /// [callPath] 运行时调用的路径
  /// [constructorName] 构造函数名称
  /// [args] 方法的参数
  dynamic createInstance(
    FlutterRuntimeCallPath callPath,
    String constructorName, [
    Map args = const {},
  ]);
}
