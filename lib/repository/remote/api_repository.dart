import 'dart:io';

import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import '../../network/api/api_constant.dart';
import '../../network/api/api_service.dart';
import '../../network/api/data_state.dart';
import '../repository.dart';

class ApiRepository implements Repository {
  final ApiService apiService;

  ApiRepository({required this.apiService});

  @override
  Future<DataState<ResultPhoto>> getPhotos(
      {String appSecret = ApiConstant.kAppSecret,
        required int page}) async {
    try {
      final httpResponse = await apiService.getPhotos(
          appSecret: appSecret, page: page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          type: DioErrorType.cancel,
          error: httpResponse.response.statusMessage,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }


  @override
  Future<DataState<ResultCategory>> getCategory(
      {String appSecret = ApiConstant.kAppSecret,
      required int page}) async {
    try {
      final httpResponse = await apiService.getCategory(
          appSecret: appSecret, page: page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          type: DioErrorType.cancel,
          error: httpResponse.response.statusMessage,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ResultPhoto>> getPhotosByCategoryId(
      {String appSecret = ApiConstant.kAppSecret,
      required int categoryId,
      required int page}) async {
    try {
      final httpResponse = await apiService.getPhotosByCategory(
          appSecret: appSecret, categoryId: categoryId, page: page);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
          type: DioErrorType.cancel,
          error: httpResponse.response.statusMessage,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
