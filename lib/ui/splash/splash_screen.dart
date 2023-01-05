import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/utils/app_constant.dart';
import '../../common/utils/image_assets.dart';
import '../../common/utils/navigation.dart';
import '../../common/utils/sizes.dart';
import '../home/home_screen.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> _getVersion() async {
    return AppConstant.appVersion;
  }

  _startSplashScreen() async {
    Future.delayed(const Duration(seconds: 2), () async {
      _navigationPage();
    });
  }

  void _navigationPage() {
    Navigation.intentWithClearAllRoutes(context, HomeScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: Sizes.width(context) / 3,
                width: Sizes.width(context) / 3,
                child: Image.asset(
                  ImagesAssets.NVPNIcon,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<String>(
                future: _getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  var verInfo = "";
                  if (snapshot.hasData) {
                    verInfo = "V ${snapshot.data}";
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      verInfo,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
