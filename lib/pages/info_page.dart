// 资讯页面
import 'package:fluent_ui/fluent_ui.dart';

class InfoPage extends StatefulWidget {

  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}
class _InfoPageState extends State<InfoPage>{

  bool disabled=false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('掘金资讯'),
      ),
      children: [],
    );
  }
}