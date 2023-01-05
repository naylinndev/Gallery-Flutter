import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/app_constant.dart';
import '../../network/api/data_state.dart';
import '../../repository/repository.dart';
import 'get_photos_by_category_event.dart';
import 'get_photos_by_category_state.dart';

class GetPhotosByCategoryBloc
    extends Bloc<GetPhotosByCategory, GetPhotosByCategoryState> {
  final Repository repository;

  GetPhotosByCategoryBloc({required this.repository})
      : super(InitialGetPhotosByCategory()) {
    on<GetPhotosByCategory>(_getPhotosByCategory);
  }

  void _getPhotosByCategory(
    GetPhotosByCategory event,
    Emitter<GetPhotosByCategoryState> emit,
  ) async {
    emit(GetPhotosByCategoryLoading());

    final dataState = await repository.getPhotosByCategoryId(
        categoryId: event.categoryId, page: event.page);
    if (dataState is DataSuccess) {
      if (dataState.data!.list.isEmpty) {
        emit(const GetPhotosByCategoryNoData(AppConstant.noData));
      } else {
        emit(GetPhotosByCategoryHasData(result: dataState.data!));
      }
    } else if (dataState is DataFailed) {
      final e = dataState.error!;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        emit(GetPhotosByCategoryNoInternetConnection());
      } else if (e.type == DioErrorType.cancel) {
        emit(GetPhotosByCategoryNoInternetConnection());
      } else {
        emit(GetPhotosByCategoryError(e.message));
      }
    }
  }
}
