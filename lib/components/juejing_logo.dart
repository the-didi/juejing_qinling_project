import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = 50.0;
    double width = 150.0;
    return Container(
        width: width,
        height: height,
        child: Center(
          child: SvgPicture.asset(
            "assets/images/svg/logo.svg",
          ),
        ));
  }
}
