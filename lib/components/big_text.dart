import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
class BigText extends StatelessWidget{

  final Color? color;

  final String text;

  double size;

  TextOverflow overflow;

  BigText({
    Key? key,
    this.color=const Color(0xff332d2b),
    required this.text,
    this.size=30,
    this.overflow=TextOverflow.ellipsis}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: size,color: color,overflow: overflow))
    );
  }


}