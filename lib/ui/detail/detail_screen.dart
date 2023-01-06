import 'dart:async';

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/styles/color_palettes.dart';
import '../../common/utils/ad_manager.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/argument.dart';
import '../../common/utils/navigation.dart';
import '../../common/utils/sizes.dart';

import '../../widget/progress/loading_horizontal_thumbnail.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  PhotoDetailArgument arguments;

  DetailScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalettes.lightAccent,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          title: Text(
            widget.arguments.photo.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorPalettes.black),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15, right: 5, bottom: 10),
                child: Text(
                  widget.arguments.photo.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: ColorPalettes.black),
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_sharp,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Description',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorPalettes.black),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15, right: 5, bottom: 10),
                child: Text(
                  widget.arguments.photo.description,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: ColorPalettes.black),
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 0.5,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Model',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorPalettes.black),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15, right: 5, bottom: 10),
                child: Text(
                  '${widget.arguments.photo.make}, ${widget.arguments.photo.model}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: ColorPalettes.black),
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 0.5,
              ),
              Container(
                margin: EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 20),
                child: CachedNetworkImage(
                  imageUrl: widget.arguments.photo.image,
                  width: Sizes.width(context),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LoadingHorizontalThumbnail(),
                  errorWidget: (context, url, error) =>
                      LoadingHorizontalThumbnail(),
                ),
              )
            ],
          ),
        ));
  }
}
