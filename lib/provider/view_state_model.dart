import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_start/provider/view_state.dart';
import 'package:dio/dio.dart';

class ViewStateModel extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  late ViewState _viewState;

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateModel({ViewState? viewState}) {
    _viewState = viewState ?? ViewState.idle;
  }
  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  /// ViewState
  ViewState get viewState => _viewState;
  ViewStateError? get viewStateError => _viewStateError;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  ///
  /// get
  bool get isBusy => viewState == ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError(e, stackTrace, {String? message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // timeout
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.cancel) {
        // to be continue...
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        // if (e is UnAuthorizedException) {
        //   stackTrace = null;
        //   errorType = ViewStateErrorType.unauthorizedError;
        // } else if (e is NotSuccessException) {
        //   stackTrace = null;
        //   message = e.message;
        // } else
        if (e is SocketException) {
          errorType = ViewStateErrorType.networkTimeOutError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: e.toString(),
    );
    printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError? viewStateError) {}

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
