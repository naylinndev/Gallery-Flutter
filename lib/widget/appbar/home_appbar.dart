import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/styles/color_palettes.dart';
import '../../common/utils/app_constant.dart';
import '../../common/utils/image_assets.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalettes.darkAccent,
      shadowColor: Colors.white,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      title: const Center(
        child: Text(
          AppConstant.appName,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
