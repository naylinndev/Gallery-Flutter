
import 'package:gallery/network/model/category.dart';
import 'package:gallery/network/model/photo.dart';

class PhotoDetailArgument {
  final Photo photo;
  PhotoDetailArgument(this.photo);
}

class CategoryDetailArgument {
  final Category category;
  CategoryDetailArgument(this.category);
}