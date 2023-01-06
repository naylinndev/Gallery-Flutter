import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/styles/color_palettes.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/image_assets.dart';

class HomeAppBar extends StatelessWidget {
  final String title;

  HomeAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalettes.darkAccent,
      shadowColor: Colors.white,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
