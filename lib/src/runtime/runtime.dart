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
  late T element;

  /// 运行时创建对象的实现
  T create();
}
