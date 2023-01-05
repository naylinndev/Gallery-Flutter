import 'dart:io';

import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:retrofit/retrofit.dart';

import '../network/api/api_constant.dart';
import '../network/api/data_state.dart';

abstract class Repository {
  Future<DataState<ResultPhoto>> getPhotos(
      {String appSecret = ApiConstant.kAppSecret,
        required int page});

  Future<DataState<ResultCategory>> getCategory(
      {String appSecret = ApiConstant.kAppSecret,
      required int page});

  Future<DataState<ResultPhoto>> getPhotosByCategoryId(
      {String appSecret = ApiConstant.kAppSecret,
      required int categoryId,
      required int page});
}
