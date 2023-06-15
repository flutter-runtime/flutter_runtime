import 'dart:async';

abstract class FlutterRuntime<T> {
  final T runtime;
  FlutterRuntime(this.runtime);

  // 获取当前类公开只读的属性
  dynamic getField(String fieldName);
  // 执行当前类的公开方法
  FutureOr call(String methodName, [Map args = const {}]);
  // 根据类名创建类实例
  dynamic createInstance(String className, [Map args = const {}]) {
    return null;
  }
}
