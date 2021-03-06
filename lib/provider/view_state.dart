
enum ViewState {
  idle,
  ///加载中
  busy,
  /// 无数据
  empty,
  /// 失败
  error
}

/// 错误类型
enum ViewStateErrorType {
  defaultError,
  networkTimeOutError, //网络错误
  unauthorizedError //为授权(一般为未登录)
}

class ViewStateError {
  late ViewStateErrorType _errorType;
  String? message;
  String errorMessage;

  ViewStateError(ViewStateErrorType? errorType, {this.message, required this.errorMessage}) {
    _errorType = errorType ?? ViewStateErrorType.defaultError;
    message ??= errorMessage;
  }
  ViewStateErrorType get errorType => _errorType;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  get isNetworkTimeOut => _errorType == ViewStateErrorType.networkTimeOutError;
  get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message, errorMessage: $errorMessage}';
  }
}