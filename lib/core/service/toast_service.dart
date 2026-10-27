import 'package:ecommerce_frontend/core/service/app_global_context.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static final Set<String> _activeToasts = {};

  // Unified color palette matching the onboarding design
  static const _successColor = Color(0xFF10B981);
  static const _errorColor = Color(0xFFEF4444);
  static const _warningColor = Color(0xFFF59E0B);
  static const _infoColor = Color(0xFF2563EB);

  // static void _safeShowToast({
  //   required BuildContext? context,
  //   required void Function(BuildContext ctx) showFunction,
  //   required String message,
  // }) {
  //   if (_activeToasts.contains(message)) return;

  //   final ctx = context ?? AppGlobalContext.context;
  //   if (ctx != null) {
  //     try {
  //       _activeToasts.add(message);
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         showFunction(ctx);

  //         Future.delayed(Duration(seconds: 4), () {
  //           _activeToasts.remove(message);
  //         });
  //       });
  //     } catch (e) {}
  //   }
  // }

  static void _safeShowToast({
    required BuildContext? context,
    required void Function(BuildContext ctx) showFunction,
    required String message,
  }) {
    if (_activeToasts.contains(message)) return;

    final ctx = context ?? AppGlobalContext.context;

    if (ctx == null || !ctx.mounted) {
      debugPrint('Toast not shown: BuildContext is null or unmounted.');
      return;
    }

    _activeToasts.add(message);

    try {
      showFunction(ctx);

      Future.delayed(const Duration(seconds: 4), () {
        _activeToasts.remove(message);
      });
    } catch (e, stackTrace) {
      _activeToasts.remove(message);
      debugPrint('Failed to show toast: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  static void _show({
    required BuildContext ctx,
    required ToastificationType type,
    required Color color,
    required String message,
    required Duration duration,
    required Alignment alignment,
  }) {
    toastification.show(
      context: ctx,
      type: type,
      style: ToastificationStyle.minimal,
      autoCloseDuration: duration,
      alignment: alignment,
      title: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1E293B),
        ),
      ),
      primaryColor: color,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      applyBlurEffect: false,
    );
  }

  static void removeAll() {
    Toastification().dismissAll();
  }

  static void showToast({
    required String message,
    required Color color,
    BuildContext? context,
    Color? backgroundColor,
    Color? textColor,
    ToastificationType type = ToastificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    _safeShowToast(
      context: context,
      message: message,
      showFunction: (ctx) => _show(
        ctx: ctx,
        type: type,
        color: color,
        message: message,
        duration: duration,
        alignment: Alignment.topRight,
      ),
    );
  }

  static void showErrorToast({
    required String message,
    BuildContext? context,
    Duration duration = const Duration(seconds: 4),
    Alignment alignment = Alignment.topRight,
  }) {
    _safeShowToast(
      context: context,
      message: message,
      showFunction: (ctx) => _show(
        ctx: ctx,
        type: ToastificationType.error,
        color: _errorColor,
        message: message,
        duration: duration,
        alignment: alignment,
      ),
    );
  }

  static void showSuccessToast({
    required String message,
    BuildContext? context,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    _safeShowToast(
      context: context,
      message: message,
      showFunction: (ctx) => _show(
        ctx: ctx,
        type: ToastificationType.success,
        color: _successColor,
        message: message,
        duration: duration,
        alignment: alignment,
      ),
    );
  }

  static void showWarningToast({
    required String message,
    BuildContext? context,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    _safeShowToast(
      context: context,
      message: message,
      showFunction: (ctx) => _show(
        ctx: ctx,
        type: ToastificationType.warning,
        color: _warningColor,
        message: message,
        duration: duration,
        alignment: alignment,
      ),
    );
  }

  static void showInfoToast({
    required String message,
    BuildContext? context,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    _safeShowToast(
      context: context,
      message: message,
      showFunction: (ctx) => _show(
        ctx: ctx,
        type: ToastificationType.info,
        color: _infoColor,
        message: message,
        duration: duration,
        alignment: alignment,
      ),
    );
  }
}
