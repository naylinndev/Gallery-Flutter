import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gallery/network/api/api_constant.dart';
import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstant.kBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/api/v1/get-photos')
  @FormUrlEncoded()
  Future<HttpResponse<ResultPhoto>> getPhotos(
      {@Field('app_secret') required String appSecret,
      @Field('page') required int page});

  @POST('/api/v1/get-category')
  @FormUrlEncoded()
  Future<HttpResponse<ResultCategory>> getCategory(
      {@Field('app_secret') required String appSecret,
      @Field('page') required int page});

  @POST('/api/v1/get-photos-by-category')
  @FormUrlEncoded()
  Future<HttpResponse<ResultPhoto>> getPhotosByCategory(
      {@Field('app_secret') required String appSecret,
      @Field('category_id') required int categoryId,
      @Field('page') required int page});
}
