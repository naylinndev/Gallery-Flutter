// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultCategory _$ResultCategoryFromJson(Map<String, dynamic> json) =>
    ResultCategory(
      json['status'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['current_page'] as int,
      json['has_more_pages'] as bool,
    );

Map<String, dynamic> _$ResultCategoryToJson(ResultCategory instance) =>
    <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'has_more_pages': instance.hasMorePages,
      'data': instance.list,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['id'] as int,
      json['category_name'] as String,
      json['category_image'] as String,
      json['updated_at'] as int,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'category_name': instance.categoryName,
      'category_image': instance.categoryImage,
      'updated_at': instance.updatedAt,
    };
