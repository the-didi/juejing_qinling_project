// 沸点资讯
import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:juejing_qingling_project/components/image_choose.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import '../components/flutter_emoji_picker.dart';
import '../utils/image_picker_windows.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // 复制粘贴过来的 其实没什么用处
  bool disabled = false;

  bool isOpen = false;

  int currentState = 1;

  String newComment = "";

  dynamic maybeHappenError = "";

  bool _imageShow = false;

  bool emojiIsShow = false;

  // 图片选择器
  final ImagePickerPlatform _picker = ImagePickerPlatform.instance;

  // 控制发布沸点 图片列表
  List<PickedFile>? _imageFileList;

  final _clearController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _clearController.addListener(() {
      if (_clearController.text.length == 1 && mounted) setState(() {});
    });
  }

  void _setImageFileListFromFile(PickedFile? value) {
    _imageFileList = value == null ? null : <PickedFile>[value];
    print(_imageFileList);
  }

  // 选择图片添加到图片列表
  Future<void> _selectImageAddToList(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    print("进入到了从文件夹选择图片方法");

    try {
      final PickedFile? file =
          await ImagePickerWindows().pickImage(source: source);
      print(file);
      setState(() {
        _imageShow = true;
        _setImageFileListFromFile(file);
      });
    } catch (e) {
      setState(() {
        maybeHappenError = e;
      });
      print(e);
    }
  }

  /// 图片预览模块 如果说有返回图片的话，那么就返回图片列表,否则的话就返回一个sizedBox
  Widget _previewImages() {
    if (_imageShow && _imageFileList != null) {
      return ImageChooseComponent(_imageFileList, (isShow) {
        print(isShow);
        setState(() {
          _imageShow = isShow;
        });
      });
    } else {
      return const SizedBox();
    }
  }

  /// 表情选择模块，这个模块选择表情,
  Widget showEmojiPicker() {
    return SizedBox();
  }

  /// 构建头部方法
  Widget _writeActivitySection() {
    return Card(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)),
        backgroundColor: Color(0xffffffff),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                TextFormBox(
                  maxLines: null,
                  controller: _clearController,
                  suffixMode: OverlayVisibilityMode.always,
                  minHeight: 150,
                  expands: true,
                  suffix: _clearController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(FluentIcons.chrome_close),
                          onPressed: () {
                            _clearController.clear();
                          },
                        ),
                  placeholder: '快和掘友一起分享新鲜事! 告诉你一个小秘密,发布沸点时添加圈子和话题能被更多人看到哦!',
                  inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                  onChanged: (value) {
                    this.setState(() {
                      this.newComment = value;
                    });
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 15,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              image: const CircleAvatar(
                                radius: 12.0,
                                child: FlutterLogo(size: 14.0),
                              ),
                              text: const Text('请选择你的圈子'),
                              onPressed: () {
                                showBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return BottomSheet(
                                      description: const Text('请选择你的圈子'),
                                      children: [
                                        const ListTile(
                                          leading: Icon(FluentIcons.mail),
                                          title: Text('Label'),
                                          subtitle: Text('Label'),
                                          trailing:
                                              Icon(FluentIcons.chevron_right),
                                        ),
                                        TappableListTile(
                                          leading: const Icon(FluentIcons.mail),
                                          title: const Text('Label'),
                                          subtitle: const Text('Label'),
                                          trailing: const Icon(
                                              FluentIcons.chevron_right),
                                          onTap: () {
                                            print('tapped tile');
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            Text("${this.newComment.length}/1000")
                          ],
                        ),
                        _previewImages()
                      ],
                    ),
                  ),
                )
              ],
            ),
            // 下方模块开始
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("链接按钮得到了点击");
                                },
                                child: Flyout(
                                  openMode: FlyoutOpenMode.press,
                                  placement: FlyoutPlacement.center,
                                  content: (context) {
                                    return Container(
                                      width: 500.0,
                                      child: FlutterEmojiPicker(),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: const [
                                      Icon(FluentIcons.emoji),
                                      Text(" 表情")
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _selectImageAddToList(
                                    ImageSource.gallery);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(FluentIcons.picture),
                                  Text(" 图片")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("链接按钮得到了点击");
                                },
                                child: Flyout(
                                  openMode: FlyoutOpenMode.press,
                                  placement: FlyoutPlacement.center,
                                  content: (context) {
                                    return Container(
                                      width: 500.0,
                                      child: FlutterEmojiPicker(),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(FluentIcons.link),
                                      Text(" 链接")
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("话题按钮得到了点击");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(FluentIcons.comment),
                                  Text(" 话题")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  child: const Text('发布'),
                  onPressed: this.newComment.length == 0
                      ? null
                      : () {
                          print('pressed filled button');
                        },
                ),
              ],
            )
            // 下方模块结束
          ],
        ));
  }

  /// 构建下方沸点列表框
  List<Widget> _writeActivityListSection() {
    return List.filled(
        20,
        Container(

            /// 主体布局
            child: Column(
          children: <Widget>[
            Card(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
              backgroundColor: Color(0xffffffff),
              child: Column(
                children: <Widget>[
                  /// 头部大模块布局
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 这里是头像部分
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        child: Image.network(
                          'https://p26-passport.byteacctimg.com/img/user-avatar/9df05ee4be63fc38375bdfeb9931fa6f~300x300.image',
                          width: 75.0,
                          height: 75.0,
                        ),
                      ),

                      /// 这里是沸点内容部分
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "你太有才了",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "专注前端的打字员 @有才 · 1小时前",
                              style: TextStyle(color: Color(0xffe5e5e5)),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth: 300.0, maxWidth: 700.0),
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                softWrap: true,
                                maxLines: this.isOpen ? 100 : 3,
                              ),
                            ),
                            TextButton(
                                child: Text('${!this.isOpen ? '展开' : '收起'}'),
                                onPressed: () {
                                  this.setState(() {
                                    this.isOpen = !this.isOpen;
                                  });
                                  print("展开收起逻辑");
                                }),
                          ],
                        ),
                      )
                    ],
                  ),

                  /// 底部按钮模块布局
                  Container(
                      decoration: new BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1.0, color: Color(0xffe5e5e5)))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            /// 分享
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.share,
                                  size: 14.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("分享")
                              ],
                            ),

                            /// 评论
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.comment,
                                  size: 14.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("评论")
                              ],
                            ),

                            /// 点赞
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FluentIcons.like,
                                  size: 14.0,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("点赞")
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        )));
  }

  /// 加载方法
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: const Text('掘金沸点'),
        commandBar: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.noWrap,
            primaryItems: <CommandBarItem>[
              CommandBarButton(
                label: const Text('最新'),
                onPressed: () {
                  this.setState(() {
                    this.currentState = 1;
                  });
                },
              ),
              CommandBarButton(
                label: const Text('热门'),
                onPressed: () {
                  this.setState(() {
                    this.currentState = 2;
                  });
                },
              ),
              CommandBarButton(
                label: const Text('关注'),
                onPressed: () {
                  this.setState(() {
                    this.currentState = 3;
                  });
                },
              ),
              CommandBarButton(
                label: const Text('我的圈子'),
                onPressed: () {
                  this.setState(() {
                    this.currentState = 4;
                  });
                },
              ),
            ]),
      ),
      children: <Widget>[
        showEmojiPicker(),

        /// 调用构建头部方法
        _writeActivitySection(),
        SizedBox(
          height: 50.0,
        ),

        /// 构建下方ListView
        ..._writeActivityListSection(),
      ],
    );
  }
}
