import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils/app_constant.dart';
import '../../network/api/data_state.dart';
import '../../repository/repository.dart';
import 'get_photos_event.dart';
import 'get_photos_state.dart';

class GetPhotosBloc extends Bloc<GetPhotos, GetPhotosState> {
  final Repository repository;

  GetPhotosBloc({required this.repository})
      : super(InitialGetPhotos()) {
    on<GetPhotos>(_getPhotos);
  }

  void _getPhotos(
    GetPhotos event,
    Emitter<GetPhotosState> emit,
  ) async {
    emit(GetPhotosLoading());


    final dataState =
        await repository.getPhotos(page: event.page);
    if (dataState is DataSuccess) {
      if(dataState.data!.list.isEmpty){
        emit(const GetPhotosNoData(AppConstant.noData));
      }else {
        emit(GetPhotosHasData(result: dataState.data!));
      }
    } else if (dataState is DataFailed) {
      final e = dataState.error!;
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        emit(GetPhotosNoInternetConnection());
      } else if (e.type == DioErrorType.cancel) {
        emit(GetPhotosNoInternetConnection());
      } else {
        emit(GetPhotosError(e.message));
      }
    }
  }
}
