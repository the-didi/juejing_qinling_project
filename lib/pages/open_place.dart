// 开放社区
import 'package:fluent_ui/fluent_ui.dart';

class OpenPlacePage extends StatefulWidget {

  const OpenPlacePage({Key? key}) : super(key: key);

  @override
  _OpenPlaceState createState() => _OpenPlaceState();
}
class _OpenPlaceState extends State<OpenPlacePage>{

  bool disabled=false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('开放社区'),
      ),
      children: [],
    );
  }
}