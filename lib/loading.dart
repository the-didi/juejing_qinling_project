import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juejing_qingling_project/pages/login.dart';
import 'dart:ui' as ui;

import 'package:juejing_qingling_project/pages/my_home_page.dart';
import 'package:lottie/lottie.dart';
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> with SingleTickerProviderStateMixin  {

  late AnimationController _controller;

  final bool _isLogin=false;


  @override
  void initState(){
    super.initState();
    //在加载页面停顿3秒
    Future.delayed(Duration(seconds: 3),(){
      if(_isLogin){
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration:const Duration(milliseconds: 500),
                pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation){
                  return FadeTransition(opacity: animation,child:const MyHomePage(),);
                }
            )
        );
      }else{
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration:const Duration(milliseconds: 500),
                pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secondaryAnimation){
                  return FadeTransition(opacity: animation,child:LoginPage(),);
                }
            )
        );
      }

      // Navigator.of(context).pushReplacementNamed("app");
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      )
    );
  }
}
class PaperPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width/2, size.width/2);
    Paint paint=Paint()
        ..style=PaintingStyle.fill
        ..strokeWidth=2
        ..color=Colors.purpleAccent;
    Path path=Path()
        ..relativeMoveTo(0, 0)
        ..relativeLineTo(20, 20)
        ..relativeLineTo(-20, -20)
        ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}