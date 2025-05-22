// lib/shared/utils/ui_helper.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelper {
  /// ✅ 전역 scaffoldMessengerKey
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// ✅ 전역 navigatorKey
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// ✅ SnackBar 표시 (context 있으면 context 기반, 없으면 전역)
  static void showSnack(String message,
      {BuildContext? context, int seconds = 2}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: seconds),
    );

    if (context != null) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      } catch (_) {}
    }

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  /// ✅ AlertDialog 표시 (context가 없으면 navigatorKey로 표시 시도)
  static Future<void> showDialogBox({
    BuildContext? context,
    required String title,
    required String content,
    String confirmText = 'OK',
  }) async {
    final ctx = context ?? navigatorKey.currentContext;
    if (ctx == null) return;

    return showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// ✅ Toast 메시지
  static void showToast(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  /// ✅ 일반 페이지 이동
  static Future<T?> navigateTo<T extends Object?>(
    Widget page, {
    BuildContext? context,
  }) {
    final ctx = context ?? navigatorKey.currentContext;
    if (ctx == null) return Future.value(null);

    return Navigator.push<T>(
      ctx,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// ✅ 현재 페이지 교체 이동
  static Future<T?> navigateReplace<T extends Object?>(
    Widget page, {
    BuildContext? context,
  }) {
    final ctx = context ?? navigatorKey.currentContext;
    if (ctx == null) return Future.value(null);

    return Navigator.pushReplacement<T, T>(
      ctx,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
