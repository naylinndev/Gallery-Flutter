import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery/bloc/get_photos/bloc.dart';
import 'package:gallery/bloc/get_photos_by_category/bloc.dart';
import 'package:gallery/ui/photo/photo_screen.dart';
import '../bloc/get_category/get_category_bloc.dart';
import '../di/injection_container.dart';
import '../ui/home/home_screen.dart';
import '../ui/category/category_screen.dart';
import '../ui/photos_by_category/photo_by_category_screen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/detail/detail_screen.dart';
import '../common/utils/argument.dart';
import 'app_config.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<GetPhotosBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<GetCategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<GetPhotosByCategoryBloc>(),
        ),
      ],
      child: _buildWithTheme(context),
    );
  }

  Widget _buildWithTheme(BuildContext context) {
    return MaterialApp(
      title: Config.title,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(title: Config.title),
        PhotoScreen.routeName: (context) => const PhotoScreen(),
        CategoryScreen.routeName: (context) => const CategoryScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
          arguments:
          ModalRoute.of(context)?.settings.arguments as PhotoDetailArgument,
        ),
        PhotoByCategoryScreen.routeName: (context) => PhotoByCategoryScreen(
          arguments:
          ModalRoute.of(context)?.settings.arguments as CategoryDetailArgument,
        ),
      },
    );
  }
}
