import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
class SmallText extends StatelessWidget{

  final Color? color;

  final String text;

  double size;

  TextOverflow overflow;

  double height;

  SmallText({
    Key? key,
    this.color=const Color(0xff89dad0),
    required this.text,
    this.size=12,
    this.height=1.5,
    this.overflow=TextOverflow.ellipsis}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        overflow: overflow,

        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: size,height: height,color: color))
    );
  }


}