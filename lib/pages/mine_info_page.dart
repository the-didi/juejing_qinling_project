// 个人主页
import 'package:fluent_ui/fluent_ui.dart';

class MineInfoPage extends StatefulWidget {

  const MineInfoPage({Key? key}) : super(key: key);

  @override
  _MineInfoPageState createState() => _MineInfoPageState();
}
class _MineInfoPageState extends State<MineInfoPage>{

  bool disabled=false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('我的主页'),
      ),
      children: [],
    );
  }
}