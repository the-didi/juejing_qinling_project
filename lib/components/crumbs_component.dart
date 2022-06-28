// 这里是面包屑组件
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class CrumbsComponent extends StatelessWidget{
    final String title;
    final String timeStr;
    final String label;
    CrumbsComponent({required this.title,required this.timeStr,required this.label});

    @override
    Widget build(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text(title),SizedBox(width: 3.0,),Icon(Icons.label_outline),SizedBox(width: 3.0,),Text(timeStr),SizedBox(width: 3.0,),Icon(Icons.label_outline),SizedBox(width: 3.0,),Text(label)],
        )
      );

  }
}