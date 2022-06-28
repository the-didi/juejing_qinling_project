import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:juejing_qingling_project/components/JueJing_fab.dart';
import 'package:juejing_qingling_project/main.dart';
import 'package:juejing_qingling_project/pages/SettingPage.dart';
import 'package:juejing_qingling_project/pages/activity_page.dart';
import 'package:juejing_qingling_project/pages/home_page.dart';
import 'package:juejing_qingling_project/pages/info_page.dart';
import 'package:juejing_qingling_project/pages/mine_info_page.dart';
import 'package:juejing_qingling_project/pages/open_place.dart';
import 'package:juejing_qingling_project/pages/shaky_page.dart';
import 'package:juejing_qingling_project/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:window_manager/window_manager.dart';

import '../components/juejing_logo.dart';
import '../components/window_buttons.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value=false;
  int index=0;
  final settingsController=ScrollController();
  final viewKey=GlobalKey();



  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fabWidgets=[
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red
        ),
      ),
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red
        ),
      ),
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red
        ),
      ),
    ];
    Widget center=Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green
      ),
    );
    final appTheme=context.watch<AppTheme>();
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: (){
          if(kIsWeb) return const Text("自由编程协会");
          return const DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(" 自由编程协会"),
              ),
          );
        }(),
        actions:kIsWeb
            ?null:
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [Spacer(),WindowButtons()],
        )
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i)=> setState(()=>index=i),
        size: const NavigationPaneSize(
          openMinWidth:250,
          openMaxWidth:320
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: LogoContainer()
        ),
        displayMode: appTheme.displayMode,
        indicator: (){
          switch(appTheme.indicator){
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items:[
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('首页'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.add_to),
            title: const Text('沸点'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.info),
            title: const Text('资讯'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.action_center),
            title: const Text('活动'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('开放社区'),
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.link),
            title: const Text('友情链接'),
            link: 'https://freeprogramming.cn',
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.account_browser),
            title: const Text('我的'),
          ),
        ],
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('设置'),
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.open_source),
            title: const Text('关于作者'),
            link: 'https://github.com/the-didi',
          ),
        ],

      ),
      content: Stack(
        children: [
          NavigationBody(index: index,children: [
            // 首页
            HomePage(),
            // 沸点
            ActivityPage(),
            // 资讯
            InfoPage(),
            // 活动
            ShakyPage(),
            // 开放社区
            OpenPlacePage(),
            // 我的主页
            MineInfoPage(),
            // 设置
            MineInfoPage(),
            SettingPage()
          ],),
          Positioned(
              bottom: 20.0,
              right: 20.0,
              child: JueJingFabComponent()
          )
        ],
      )
    );
  }
  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if(_isPreventClose){
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('确定关闭'),
            content: const Text('您确定要退出掘金青柠吗?'),
            actions: [
              FilledButton(
                child: const Text('是'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('否'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
    icon: icon,
    title: title,
    infoBadge: infoBadge,
    focusNode: focusNode,
    autofocus: autofocus,
  );

  final String link;

  @override
  Widget build(
      BuildContext context,
      bool selected,
      VoidCallback? onPressed, {
        PaneDisplayMode? displayMode,
        bool showTextOnTop = true,
        bool? autofocus,
      }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}