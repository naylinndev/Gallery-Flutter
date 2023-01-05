import 'package:equatable/equatable.dart';

abstract class GetPhotosEvent extends Equatable {
  const GetPhotosEvent();

  @override
  List<Object> get props => [];
}

class GetPhotos extends GetPhotosEvent {
  final int page;

  const GetPhotos({required this.page});

  @override
  List<Object> get props => [page];
}
