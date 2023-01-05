
import 'package:gallery/bloc/get_category/bloc.dart';
import 'package:gallery/bloc/get_photos/bloc.dart';
import 'package:gallery/bloc/get_photos_by_category/bloc.dart';
import 'package:gallery/repository/gallery_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/api/api_service.dart';
import '../repository/remote/api_repository.dart';
import '../repository/repository.dart';

final injector = GetIt.instance;

Future<void> init(String baseUrl) async {
  injector.registerSingleton<Dio>(Dio());


  // Network
  injector.registerLazySingleton(() => ApiService(injector()));

  // Repository
  injector.registerLazySingleton(() => ApiRepository(apiService: injector()));
  injector.registerLazySingleton<Repository>(() =>
      GalleryRepository(apiRepository: injector()));

  // BLoC
  injector.registerFactory(() => GetPhotosBloc(repository: injector()));
  injector.registerFactory(() => GetCategoryBloc(repository: injector()));
  injector.registerFactory(() => GetPhotosByCategoryBloc(repository: injector()));
}
