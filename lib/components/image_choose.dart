import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/image_picker_windows.dart';

class ImageChooseComponent extends StatefulWidget {
  final List<PickedFile>? _imageFileList;

  final ValueChanged<bool> _imageStateChangeCallback;

  ImageChooseComponent(this._imageFileList,this._imageStateChangeCallback);
  @override
  _ImageChooseComponentState createState() => _ImageChooseComponentState();
}

class _ImageChooseComponentState extends State<ImageChooseComponent> {


  /// 新增图片方法
  void _addImages()async {
    final PickedFile? file=await ImagePickerWindows().pickImage(source: ImageSource.gallery);
    file!=null?widget._imageFileList?.add(file):null;
    print("新增图像方法得到了执行,现在观察数组长度:${widget._imageFileList?.length}");
    setState((){});
  }
  /// 删除图片方法
  void _deleteImages(int index) async {
    widget._imageFileList?.removeAt(index);
    if(widget._imageFileList?.length==0){
      print("长度为0,要删除父组件的imageList");
      widget._imageStateChangeCallback(false);
    }else{
      widget._imageStateChangeCallback(true);
      print("长度还不为0,还可以解救下");
    }
    setState((){});
  }

  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75.0,
        child: SizedBox(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  print("图片得到了点击");
                },
                child: SizedBox(
                  width: 500,
                  height: 60,
                  child: ListView.builder(
                    key: UniqueKey(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 5.0),

                            width: 60.0,
                            height: 60.0,
                            child: Image.file(
                              File(widget._imageFileList![index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 3,
                            top: 3,
                            child: SizedBox(
                              child: GestureDetector(
                                onTap: (){
                                  _deleteImages(index);
                                  print("关闭按钮得到了点击");
                                },
                                child: Icon(Icons.close,color: Color(0xffffffff),size: 10.0,),
                              ) ,
                            )
                          )
                        ],
                      );
                    },
                    itemCount: widget._imageFileList!.length,
                  ),
                )
              ),
              /// 上传图片按钮
              GestureDetector(
                onTap: () async {
                  _addImages();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5.0),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0,color: Color(0xffe5e5e5),)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.close)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    }
}
