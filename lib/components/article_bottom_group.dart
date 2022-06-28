
import 'package:fluent_ui/fluent_ui.dart';

class ArticleBottomGroup extends StatelessWidget{

  final int watch;

  final int like;

  final int comment;

  ArticleBottomGroup({required this.watch,required this.like,required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.red_eye),
          SizedBox(width: 2.0,),
          Text("${this.watch>=10000?this.watch/10000:this.watch}w"),
          SizedBox(width: 5.0,),
          Icon(FluentIcons.like),
          SizedBox(width: 2.0,),
          Text("${this.like}"),
          SizedBox(width: 5.0,),
          Icon(FluentIcons.comment),
          SizedBox(width: 2.0,),
          Text("${this.comment}"),
        ],
      ),
    );
  }
}