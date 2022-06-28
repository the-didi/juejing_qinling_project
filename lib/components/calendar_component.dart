import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/event.dart';

/// 整体设计逻辑
/// 1、首先写一个算法，确定每一个月的1号是星期几
/// 2、更具星期几来倒推前面那一个月的几天，填充到body grid列表当中去
/// 3、grid列表固定一定有7行6列。这里是确定的，并且默认填满
/// 4、默认页面加载的时候，将当前天传递进来
/// 5、月份改变的时候，先渲染网格，再向后台发起请求，加载当月哪些天有活动

class CalendarComponent extends StatefulWidget {
  late final DateTime currentDate;

  CalendarComponent(this.currentDate);

  @override
  CalendarComponentState createState() => CalendarComponentState();
}

class CalendarComponentState extends State<CalendarComponent> {
  List<int> monthList1 = [0,31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  late List<Active> _calendarBody;

  var showTime;

  @override
  void initState() {

    setState(() {
      showTime = widget.currentDate;
    });
    _loadCalendarBodyData();
  }

  void _loadCalendarBodyData(){
    int year=widget.currentDate.year;
    int month=widget.currentDate.month;
    int day=widget.currentDate.day;
    List<Active> tmpList=[];
    //   首先获取这个月的1号是星期几
    int currentDay=DateTime(widget.currentDate.year,widget.currentDate.month,1).weekday;
    for(int i=currentDay;i>0;i--){
      tmpList.add(Active(monthList1[widget.currentDate.month-1]-i, false, [], true,false));
    }
    // 加载之前的日期结束
    // 开始加载本月日期
    for(int i=1;i<=monthList1[widget.currentDate.month];i++){
      if(i==widget.currentDate.day){
        tmpList.add(Active(i, true, [], false,false));
      }else{
        tmpList.add(Active(i, false, [], false,false));
      }
    }
    // 开始加载本月之后的日期
    for(int i=1;i<42-(widget.currentDate.day+currentDay);i++){
      tmpList.add(Active(i, false, [], true,false));
    }
    // 对数据进行进一步的渲染
    for(int i=0;i<tmpList.length;i++){
      if(i%7==0||i%7==6){
        tmpList[i]._isWeekend=true;
      }
    }
    setState((){
      _calendarBody=tmpList;
    });
  }

  /// 此处生成一个列表，但是这个列表要分为3个部分：
  /// 1、这个月开始之前
  /// 2、这个月持续的时间
  /// 3、这个月结束之后
  /// 开始之前和结束之后，日期均以灰色显示
  /// 日期持续中间段都以浮动标蓝格显示
  List<Widget> _loadCalendarBody() {
    return List.generate(42, (index) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: _calendarBody[index]._isCurrent?Color(0xff007fff):Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: _calendarBody[index]._isOutofMonth?0.5:1.0,
                    child: Text("${_calendarBody[index]._day}",style: TextStyle(color:_calendarBody[index]._isWeekend?Color(0xff007fff):_calendarBody[index]._isCurrent?Colors.white:Colors.black54 ),),
                  )
                ],
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _loadActiveList(index),
            )
          ],
        ),
      );
    });
  }

  List<Widget> _loadActiveList(int index) {
    return List.generate(_calendarBody[index]._advs!.length, (index) {
      return Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: Colors.blue, width: 1.0)),
        child: Container(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDCDFE6), width: 1.0),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0xffe8e8e8),
            offset: Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      // alignment:Alignment.centerLeft,
      child: Flex(direction: Axis.vertical, children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    /// 点击前面这个按钮，时间就应该往前面走一个月份
                    /// 能被400整除，或者能被4整除但不能被100整除的都是闰年，其余的年份均为平年
                    /// 首先设置年
                    /// 然后设置月
                    setState(() {
                      showTime = DateTime(
                          showTime.month - 1 == 0
                              ? showTime.year - 1
                              : showTime.year,
                          showTime.month - 1 == 0 ? 12 : showTime.month - 1,
                          showTime.day
                          // (widget.currentDate.year/400==0||(widget.currentDate.year/4==0&&widget.currentDate.year/100!=0))
                          // ?widget.currentDate.month==2?28:29:
                          // monthList1[widget.currentDate.month-1]
                          );
                    });
                  },
                  child: Icon(
                    Icons.arrow_left,
                    color: Color(0xff007fff),
                  ),
                ),
                Text(
                  "${showTime.year}年 ${showTime.month}月",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff007fff)),
                ),
                GestureDetector(
                  onTap: () {
                    /// 点击前面这个按钮，时间就应该往前面走一个月份
                    /// 能被400整除，或者能被4整除但不能被100整除的都是闰年，其余的年份均为平年
                    /// 首先设置年
                    /// 然后设置月
                    setState(() {
                      showTime = DateTime(
                          showTime.month + 1 == 13
                              ? showTime.year + 1
                              : showTime.year,
                          showTime.month + 1 == 13 ? 1 : showTime.month + 1,
                          showTime.day
                          // (widget.currentDate.year/400==0||(widget.currentDate.year/4==0&&widget.currentDate.year/100!=0))
                          // ?widget.currentDate.month==2?28:29:
                          // monthList1[widget.currentDate.month-1]
                          );
                    });
                    print(this.showTime);
                  },
                  child: Icon(
                    Icons.arrow_right,
                    color: Color(0xff007fff),
                  ),
                ),
              ],
            ),
            Container(
              height: 20.0,
              color: Color(0xff007fff),
              padding: EdgeInsets.only(left: 10.0,right: 10.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "日",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "一",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "二",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "三",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "四",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "五",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "六",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
                height: 290,
                child: GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 16, //交叉轴间距
                    mainAxisSpacing: 16, //主轴间距
                    padding: EdgeInsets.all(16),
                    children: _loadCalendarBody()))
          ],
        ),
      ]),
    );
  }
}
class Active{
  int _day;
  List<String>? _advs;
  bool _isCurrent;
  bool _isOutofMonth;
  bool _isWeekend;
  Active(this._day,this._isCurrent,this._advs,this._isOutofMonth,this._isWeekend);
}
