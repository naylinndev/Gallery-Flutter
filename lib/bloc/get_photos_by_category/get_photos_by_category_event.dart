import 'package:equatable/equatable.dart';

abstract class GetPhotosByCategoryEvent extends Equatable {
  const GetPhotosByCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetPhotosByCategory extends GetPhotosByCategoryEvent {
  final int page;
  final int categoryId;

  const GetPhotosByCategory({required this.categoryId,required this.page});

  @override
  List<Object> get props => [categoryId,page];
}
