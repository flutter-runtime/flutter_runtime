import 'dart:async';

/// 生成运行时模版基础库
abstract class Runtime<T> {
  /// 默认的构造器
  /// [parameters] 动态创建请求的参数
  Runtime(this.parameters) {
    /// 会在初始化的时候进行创建对象
    element = create();
  }

  /// 创建提供的参数
  final Map<String, dynamic> parameters;

  /// 运行时创建的对象
  T? element;

  /// 运行时创建对象的实现
  T? create();

  /// 从之前的对象获取一个属性的值
  dynamic operator [](String name) {
    throw UnimplementedError();
  }

  /// 给之前的对象设置一个属性的值
  operator []=(String name, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  /// 运行时存在 Package 的相对路径
  String get relativePath;

  /// 动态执行一个方法
  /// [name] 方法的名称
  /// [data] 方法的参数
  call(String name, Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
