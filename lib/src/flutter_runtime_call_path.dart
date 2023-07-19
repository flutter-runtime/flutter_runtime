/// 调用运行时的路径配置
class FlutterRuntimeCallPath {
  /// 运行时库名称
  final String packageName;

  /// 运行时库的调用具体路径
  final String libraryPath;

  /// 运行时库的调用类
  final String className;

  /// 运行时的实例对象
  final dynamic runtime;

  FlutterRuntimeCallPath(
    this.packageName,
    this.libraryPath,
    this.className,
    this.runtime,
  );
}
