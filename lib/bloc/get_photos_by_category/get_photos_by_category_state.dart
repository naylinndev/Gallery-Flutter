import 'package:equatable/equatable.dart';
import 'package:gallery/network/model/photo.dart';

abstract class GetPhotosByCategoryState extends Equatable {
  const GetPhotosByCategoryState();

  @override
  List<Object> get props => [];
}

class InitialGetPhotosByCategory extends GetPhotosByCategoryState {}

class GetPhotosByCategoryLoading extends GetPhotosByCategoryState {}

class GetPhotosByCategoryHasData extends GetPhotosByCategoryState {
  final ResultPhoto result;

  const GetPhotosByCategoryHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class GetPhotosByCategoryNoData extends GetPhotosByCategoryState {
  final String message;

  const GetPhotosByCategoryNoData(this.message);

  @override
  List<Object> get props => [message];
}

class GetPhotosByCategoryNoInternetConnection extends GetPhotosByCategoryState {}

class GetPhotosByCategoryError extends GetPhotosByCategoryState {
  final String errorMessage;

  const GetPhotosByCategoryError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
