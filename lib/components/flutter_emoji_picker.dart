import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
class FlutterEmojiPicker extends StatelessWidget {
  final String currentText = "请选择表情";

  const FlutterEmojiPicker({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 3,
        child: Container(
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffe6e6e6),
                  offset: Offset(8, 8),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            // color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: 500.0,
                  height: 100.0,
                  color: Colors.blue,
                  child: TabBar(isScrollable: true, tabs: [
                    Tab(
                      text: "表情",
                      icon: Icon(Icons.emoji_emotions),
                    ),
                    Tab(
                      text: "颜文字",
                      icon: Icon(Icons.text_fields),
                    ),
                    Tab(
                      text: "数学符号",
                      icon: Icon(Icons.numbers),
                    )
                  ]),
                ),
                Container(
                  width: 500.0,
                  height: 250.0,
                  child: Container(
                    child: TabBarView(
                      children: [
                        Container(
                          child: _buildEmojiGridView(50.0,"🚚,🚗,🚛,🚙,🛺,🚜,🚕,🚓,🚀,😊,😂,🤣,❤,😍,😒,👌,😘,💕,😁,👍,🙌,🤦,✌,🤞,😉,😎,🎶,😢,💖,😜,👏,💋,🌹,🎉,🎂,🤳,🐱,👤,🐱,‍🏍,🐱,‍💻,🐱,‍🐉,🐱,‍👓,🐱,‍🚀,✔,👀,😃,✨,😆,🤔,🤢,🎁".split(",")),
                        ),
                        Container(
                          child: _buildEmojiGridView(100.0,"φ(*￣0￣),（￣︶￣）↗　,ψ(｀∇´)ψ,*^____^*,o(*^＠^*)o,( •̀ ω •́ ),✧(❁´◡`❁),(●'◡'●),╰(*°▽°*)╯,☆*: ,.｡., o(≧▽≦)o, .｡.:*☆,(*/ω＼*),(^///^),ᓚᘏᗢ(┬┬﹏┬┬),ಥ_ಥ,ಠ_ಠ,(╯°□°）╯︵ ┻━┻,( ´･･)ﾉ,(._.`),༼ つ ◕_◕ ༽つ,(ˉ﹃ˉ),(•_•),(☞ﾟヮﾟ)☞,(⌐■_■),( •_•)>,⌐■-■,☜(ﾟヮﾟ☜),(¬‿¬),(¬_¬ ),(T_T),¯\_(ツ)_/¯,(⊙_⊙;)".split(","))
                        ),
                        Container(
                          child: _buildEmojiGridView(50.0,"🚚,🚗,🚛,🚙,🛺,🚜,🚕,🚓,🚀,😊,😂,🤣,❤,😍,😒,👌,😘,💕,😁,👍,🙌,🤦,✌,🤞,😉,😎,🎶,😢,💖,😜,👏,💋,🌹,🎉,🎂,🤳,🐱,👤,🐱,‍🏍,🐱,‍💻,🐱,‍🐉,🐱,‍👓,🐱,‍🚀,✔,👀,😃,✨,😆,🤔,🤢,🎁".split(","))
                        ),

                      ],
                    ),
                  ),
                )
              ],
            )));
  }
  Widget _buildEmojiGridView(double extendConfig,List<String> emojiList){


    return GridView.extent(
        maxCrossAxisExtent: extendConfig,
        children: _buildGridTileList(emojiList),
    );
  }
  List<Container> _buildGridTileList(List<String> emojiList){
    return List.generate(emojiList.length, (index) => Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Text(emojiList[index]),
          )
        ],
      ),
    ));
  }



}
