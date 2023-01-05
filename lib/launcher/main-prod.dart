import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/gallery_bloc_observer.dart';
import '../di/injection_container.dart' as di;
import '../network/api/api_constant.dart';
import 'app_config.dart';
import 'gallery_app.dart';


void main() async {
  Config.appFlavor = Flavor.RELEASE;
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  await di.init(ApiConstant.kBaseUrl);


  BlocOverrides.runZoned(
        () => runApp(MyApp()),
    blocObserver: GalleryBlocObserver(),
  );
}
