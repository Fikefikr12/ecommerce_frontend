import 'package:flutter/material.dart';

class AppGlobalContext {
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static BuildContext? get context => _context;

  static bool get hasContext => _context != null;

  // The app's Navigator key (assigned to ShadApp in app.dart). Unlike
  // `context` above (which sits ABOVE the Navigator ShadApp builds, since
  // that's how MaterialApp/ShadApp.builder's context works — it can never
  // see that Navigator's own Overlay), this reaches the Navigator's
  // OverlayState directly via `navigatorKey.currentState?.overlay`, with no
  // BuildContext lookup involved at all. Use this for anything that needs
  // the app's real Overlay from outside the widget tree (e.g. printing an
  // off-screen-rendered widget).
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
