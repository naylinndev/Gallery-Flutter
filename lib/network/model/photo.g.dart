// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultPhoto _$ResultPhotoFromJson(Map<String, dynamic> json) => ResultPhoto(
      json['status'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['current_page'] as int,
      json['has_more_pages'] as bool,
    );

Map<String, dynamic> _$ResultPhotoToJson(ResultPhoto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'current_page': instance.currentPage,
      'has_more_pages': instance.hasMorePages,
      'data': instance.list,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      json['make'] as String,
      json['model'] as String,
      json['image'] as String,
      json['updated_at'] as int,
      (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'make': instance.make,
      'model': instance.model,
      'image': instance.image,
      'updated_at': instance.updatedAt,
      'categories': instance.categories,
    };
