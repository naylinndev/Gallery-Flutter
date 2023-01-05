import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/app_constant.dart';
import '../../network/api/data_state.dart';
import '../../repository/repository.dart';
import 'get_category_event.dart';
import 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategory, GetCategoryState> {
  final Repository repository;

  GetCategoryBloc({required this.repository})
      : super(InitialGetCategory()) {
    on<GetCategory>(_getCategory);
  }

  void _getCategory(
    GetCategory event,
    Emitter<GetCategoryState> emit,
  ) async {
    emit(GetCategoryLoading());


    final dataState =
        await repository.getCategory(page: event.page);
    if (dataState is DataSuccess) {
      if(dataState.data!.list.isEmpty){
        emit(const GetCategoryNoData(AppConstant.noData));
      }else {
        emit(GetCategoryHasData(result: dataState.data!));
      }
    } else if (dataState is DataFailed) {
      final e = dataState.error!;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        emit(GetCategoryNoInternetConnection());
      } else if (e.type == DioErrorType.cancel) {
        emit(GetCategoryNoInternetConnection());
      } else {
        emit(GetCategoryError(e.message));
      }
    }
  }
}
