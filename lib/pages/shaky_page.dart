// 这里是活动页面
import 'package:fluent_ui/fluent_ui.dart';

import '../components/calendar_component.dart';
import '../components/rotation_chart.dart';

class ShakyPage extends StatefulWidget {

  const ShakyPage({Key? key}) : super(key: key);

  @override
  _ShakyPageState createState() => _ShakyPageState();
}
class _ShakyPageState extends State<ShakyPage>{


  double screenWidth=0.0;

  double screenHeight=0.0;

  bool disabled=false;

  int _locationIndex=0;

  bool isHover=false;


  Widget _buildMiddle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              child: Text("全部活动",style: TextStyle(color: Color(0xffd1d1d1)),),
            ),
            SizedBox(width: 5.0,),
            Container(
              child: Text("北京",style: TextStyle(color: Color(0xffd1d1d1)),),
            ),
            SizedBox(width: 5.0,),
            Container(
              child: Text("上海",style: TextStyle(color: Color(0xffd1d1d1)),),
            ),
            SizedBox(width: 5.0,),
            Container(
              child: Text("杭州",style: TextStyle(color: Color(0xffd1d1d1)),),
            ),
            SizedBox(width: 5.0,),
            Container(
              child: Text("深圳",style: TextStyle(color: Color(0xffd1d1d1)),),
            ),
            SizedBox(width: 5.0,),
            HoverButton(
              onPressed: (){
                setState((){
                  isHover=!isHover;
                });
              },
                builder: (BuildContext context,Set hoverSet){
              return Container(
                child: Row(
                  children: [
                    Text("其他",style: TextStyle(color: Color(0xffd1d1d1)),),
                    SizedBox(width: 3.0,),
                    isHover?Icon(FluentIcons.caret_solid_down,size: 12.0,color: Color(0xffd1d1d1),):Icon(FluentIcons.caret_solid_up,size: 12.0,color: Color(0xffd1d1d1),)
                  ],
                ),
              );
            })
          ],
        ),
        TextButton(
          child: Row(
            children: [
              Icon(FluentIcons.toolbox,color: Color(0xffb1b1b1),),
              SizedBox(width: 5.0,),
              Text("寻求合作",style: TextStyle(color: Color(0xffb1b1b1)),)
            ],
          ),
          onPressed: disabled
              ? null
              : () {
            print('pressed text button');
          },
        ),
      ],
    );
  }

  
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    setState((){
      screenWidth=screenSize.width;
      screenHeight=screenSize.height;
    });
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('掘金活动'),
      ),
      children: [
        /// 头部模块开始
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: screenSize.width/2,
                child: RotationChart()
            ),
            Container(

                padding: EdgeInsets.only(left: 20.0),
                width: screenSize.width>=1200?screenSize.width/4+10:screenSize.width/3+40,
                child: Center(
                  child: CalendarComponent(DateTime.now()),
                ),
            )
          ],
        ),
        /// 头部模块结束
        /// 中部导航模块开始
        _buildMiddle(),
        /// 中部导航模块结束
        /// 底部grid活动列表模块开始
        Container(
          width: 500.0,
          height: 500.0,
          child: GridView.extent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.only(top: kPageDefaultVerticalPadding),
            children: List.generate(3, (index) => Container(child: Text("你好世界"),)),
          ),
        )

        /// 底部grid活动列表模块结束
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}