// 设置页面
import 'package:fluent_ui/fluent_ui.dart';

class SettingPage extends StatefulWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}
class _SettingPageState extends State<SettingPage>{

  bool disabled=false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('系统设置'),
      ),
      children: [],
    );
  }
}