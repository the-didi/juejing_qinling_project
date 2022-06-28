import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
typedef JueJingFabComponentItemClick = bool Function(int index);

class JueJingFabComponent extends StatefulWidget {


  @override
  FabState createState() => FabState();
}

class FabState extends State<JueJingFabComponent>{
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: Color(0xff2196f3),
      icon: Icons.person,
      children: [
        SpeedDialChild(
          child: Icon(FluentIcons.pen_workspace),
          label: "写文章"
        ),
        SpeedDialChild(
            child: Icon(Icons.text_snippet),
            label: "草稿箱"
        ),
        SpeedDialChild(
            child: Icon(Icons.remove_red_eye),
            label: "浏览记录"
        ),
        SpeedDialChild(
            child: Icon(FluentIcons.like),
            label: "我赞过的"
        ),
        SpeedDialChild(
            child: Icon(Icons.class_),
            label: "我的课程"
        ),
        SpeedDialChild(
            child: Icon(Icons.collections),
            label: "我的收藏"
        ),
        SpeedDialChild(
            child: Icon(Icons.bookmark),
            label: "标签管理"
        ),
        SpeedDialChild(
            child: Icon(Icons.logout),
            label: "退出登录"
        ),
      ],
    );
  }

}
