import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:juejing_qingling_project/pages/login.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'loading.dart';
import 'pages/my_home_page.dart';
import 'theme.dart';
const String appTitle = "";

// 判断当前应用是否是桌面应用
bool get isDesktop {
  if(kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS
  ].contains(defaultTargetPlatform);
}

void main() async {
  // 确保绑定WidgetsBinding实例
  WidgetsFlutterBinding.ensureInitialized();
  // 设置hash路由重定向
  setPathUrlStrategy();
  if(isDesktop){
    // 唤醒windows绑定方法
    await flutter_acrylic.Window.initialize();
    // 确保函数已经被唤醒了
    await WindowManager.instance.ensureInitialized();
    // 对用户界面做美化操作
    windowManager.waitUntilReadyToShow().then((_) async {
      // 首先将标题栏隐藏,并且将标题栏的按钮也隐藏
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      // 设置可见窗口的大小
      await windowManager.setSize(const Size(955, 745));
      // 设置中等应用窗口的大小
      await windowManager.setMinimumSize(const Size(955, 745));
      // 设置用户界面在计算机中心显示
      await windowManager.center();
      // 设置用户界面显示
      await windowManager.show();
      // 设置监听本机器关闭信号
      await windowManager.setPreventClose(true);
      // 设置应用程序是否在下方工具栏显示
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>AppTheme(),
        builder: (context,_){
          final appTheme=context.watch<AppTheme>();
          return FluentApp(
            scrollBehavior: AppScrollBehavior(),
            title: appTitle,

            themeMode: appTheme.mode,
            debugShowCheckedModeBanner: false,
            home: LoadingPage(),
            routes: <String,WidgetBuilder>{
              "app": (BuildContext context)=>const MyHomePage(),
              "login": (BuildContext context)=>LoginPage(),
            },
          );
        },
    );
  }
}


class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

