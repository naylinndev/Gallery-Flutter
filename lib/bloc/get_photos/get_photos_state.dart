import 'package:equatable/equatable.dart';
import 'package:gallery/network/model/photo.dart';

abstract class GetPhotosState extends Equatable {
  const GetPhotosState();

  @override
  List<Object> get props => [];
}

class InitialGetPhotos extends GetPhotosState {}

class GetPhotosLoading extends GetPhotosState {}

class GetPhotosHasData extends GetPhotosState {
  final ResultPhoto result;

  const GetPhotosHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class GetPhotosNoData extends GetPhotosState {
  final String message;

  const GetPhotosNoData(this.message);

  @override
  List<Object> get props => [message];
}

class GetPhotosNoInternetConnection extends GetPhotosState {}

class GetPhotosError extends GetPhotosState {
  final String errorMessage;

  const GetPhotosError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
