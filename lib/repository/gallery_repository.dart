import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:gallery/repository/remote/api_repository.dart';
import 'package:gallery/repository/repository.dart';
import '../network/api/api_constant.dart';
import '../network/api/data_state.dart';

class GalleryRepository implements Repository {
  final ApiRepository apiRepository;

  GalleryRepository({required this.apiRepository});

  @override
  Future<DataState<ResultCategory>> getCategory(
      {String appSecret = ApiConstant.kAppSecret, required int page}) async {
    final dataState =
        await apiRepository.getCategory(appSecret: appSecret, page: page);
    return dataState;
  }

  @override
  Future<DataState<ResultPhoto>> getPhotos(
      {String appSecret = ApiConstant.kAppSecret, required int page}) async {
    final dataState =
        await apiRepository.getPhotos(appSecret: appSecret, page: page);
    return dataState;
  }

  @override
  Future<DataState<ResultPhoto>> getPhotosByCategoryId(
      {String appSecret = ApiConstant.kAppSecret,
      required int categoryId,
      required int page}) async {
    final dataState = await apiRepository.getPhotosByCategoryId(
        appSecret: appSecret, categoryId: categoryId, page: page);
    return dataState;
  }
}
