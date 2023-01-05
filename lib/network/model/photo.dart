import 'package:equatable/equatable.dart';
import 'package:gallery/network/model/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class ResultPhoto extends Equatable {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'has_more_pages')
  final bool hasMorePages;
  @JsonKey(name: 'data')
  final List<Photo> list;

  const ResultPhoto(this.status, this.list, this.currentPage, this.hasMorePages);

  @override
  List<Object> get props => [status, list, currentPage, hasMorePages];

  factory ResultPhoto.fromJson(Map<String, dynamic> json) =>
      _$ResultPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$ResultPhotoToJson(this);
}

@JsonSerializable()
class Photo extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'make')
  final String make;
  @JsonKey(name: 'model')
  final String model;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'updated_at')
  final int updatedAt;
  @JsonKey(name: 'categories')
  final List<Category> categories;


  Photo(
      this.id,
      this.title,
      this.description,
      this.make,
      this.model,
      this.image,
      this.updatedAt,
      this.categories);

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      make,
      model,
      image,
      updatedAt,
      categories
    ];
  }

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
