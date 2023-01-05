import 'package:equatable/equatable.dart';
import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';

abstract class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

class InitialGetCategory extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryHasData extends GetCategoryState {
  final ResultCategory result;

  const GetCategoryHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class GetCategoryNoData extends GetCategoryState {
  final String message;

  const GetCategoryNoData(this.message);

  @override
  List<Object> get props => [message];
}

class GetCategoryNoInternetConnection extends GetCategoryState {}

class GetCategoryError extends GetCategoryState {
  final String errorMessage;

  const GetCategoryError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
