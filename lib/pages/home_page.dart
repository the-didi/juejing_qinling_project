import 'package:fluent_ui/fluent_ui.dart';
import 'package:juejing_qingling_project/components/article_bottom_group.dart';
import 'package:juejing_qingling_project/components/crumbs_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool disabled = false;

  bool isLoading = true;

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getArticleData() {
    return List.filled(20, HoverButton(
      builder: (context, states) {
        return FocusBorder(
          focused: states.isFocused,
          child: RepaintBoundary(
            child: AnimatedContainer(
              duration: FluentTheme.of(context).fasterAnimationDuration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CrumbsComponent(
                    title: '前端',
                    timeStr: '一个月前',
                    label: '程序员',
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xffe5e5e5)))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            constraints: BoxConstraints(
                                minHeight: 75.0, maxHeight: 200.0),
                            child: ListTile(
                              trailing: Image.network(
                                  'https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b02f29444a3745f3a35edb57fbdc318a~tplv-k3u1fbpfcp-no-mark:720:720:720:480.awebp?'),
                              title: Text(
                                "📚用技术助力公益，让代码更有温度☀️六一特别活动来袭🌈",
                                style: TextStyle(fontSize: 24.0),
                              ),
                              subtitle: Text(
                                  "本篇并不是深究内置服务器的启动过程，而是追溯Springboot启动之前到底做了什么？"),
                            )),
                        ArticleBottomGroup(
                          like: 331,
                          watch: 270000,
                          comment: 78,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //  这里开始往后台发指令要更多数据
        this.setState(() {
          this.isLoading = !this.isLoading;
        });
        //  往后台发指令命令结束
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: const Text('掘金首页'),
          commandBar: ToggleSwitch(
            checked: disabled,
            onChanged: (v) => setState(() => disabled = v),
            content: const Text('是否开启偏好推荐'),
          ),
        ),
        scrollController: _scrollController,
        children: [
          ...this._getArticleData(),
          isLoading
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: ProgressBar(),
                    ),
                    Text('正在加载...')
                  ],
                )
              : Column(
                  children: [Text("已经到最底部了")],
                )
        ]);
  }
}
