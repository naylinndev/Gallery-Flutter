import 'package:equatable/equatable.dart';

abstract class GetCategoryEvent extends Equatable {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategory extends GetCategoryEvent {
  final int page;

  const GetCategory({required this.page});

  @override
  List<Object> get props => [page];
}
