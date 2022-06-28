import 'package:flutter/material.dart';

class HoverSelect extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool isShow=false;
    return Container(
      child: InkWell(
        onHover: (state){
          isShow=state;
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("其他"),
            SizedBox(width: 3.0,),
            isShow?Icon(Icons.arrow_drop_down_rounded):Icon(Icons.arrow_drop_up)
          ],
        ),
      )

    );
  }
}