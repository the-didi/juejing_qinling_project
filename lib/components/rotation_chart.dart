import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:juejing_qingling_project/components/small_text.dart';

import 'big_text.dart';

class RotationChart extends StatefulWidget {
  @override
  RotationChartsState createState() => RotationChartsState();
}

class RotationChartsState extends State<RotationChart> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  List<RotationCharts> mockData = <RotationCharts>[
    new RotationCharts(
        url:
            "https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/03e3008290134b8e9c42305735b0df3d~tplv-k3u1fbpfcp-no-mark:460:460:460:270.awebp?",
        title: "稀土掘金开发者大会",
        formatedDate: "05-31 周二"),
    new RotationCharts(
        url:
            "https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1e29b08c66f543c189a08078d668250f~tplv-k3u1fbpfcp-no-mark:460:460:460:270.awebp?",
        title: "高校开发者大会",
        formatedDate: "05-31 周二")
  ];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320.0,
          child: PageView.builder(
            controller: pageController,
            itemCount: mockData.length,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        new DotsIndicator(
          dotsCount: mockData.length,
          position: _currentPageValue,
          decorator: DotsDecorator(
              activeColor: Colors.blue,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = new Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: _height,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(mockData[index].url))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: mockData[index].title),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 10.0,
                            ),
                            SmallText(
                              text: mockData[index].formatedDate,
                              color: Colors.black54,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 10.0,
                                ),
                                SmallText(
                                  text: "线上",
                                  color: Colors.black54,
                                )
                              ],
                            ),
                            FlatButton(
                                child: SmallText(
                                  text: '立即报名',
                                  color: Colors.white,
                                ),
                                color: Colors.blue,
                                onPressed: () {})
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
  }
}

class RotationCharts {
  final String url;
  final String title;
  final String formatedDate;
  RotationCharts(
      {required this.url, required this.title, required this.formatedDate});
}
