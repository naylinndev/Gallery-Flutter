import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class ResultCategory extends Equatable {
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'has_more_pages')
  final bool hasMorePages;
  @JsonKey(name: 'data')
  final List<Category> list;

  const ResultCategory(this.status, this.list, this.currentPage, this.hasMorePages);

  @override
  List<Object> get props => [status, list, currentPage, hasMorePages];

  factory ResultCategory.fromJson(Map<String, dynamic> json) =>
      _$ResultCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ResultCategoryToJson(this);
}

@JsonSerializable()
class Category extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'category_image')
  final String categoryImage;
  @JsonKey(name: 'updated_at')
  final int updatedAt;


  const Category(
      this.id,
      this.categoryName,
      this.categoryImage,
      this.updatedAt);

  @override
  List<Object> get props {
    return [
      id,
      categoryName,
      categoryImage,
      updatedAt
    ];
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
