import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../common/styles/color_palettes.dart';
import '../../common/utils/image_assets.dart';
import '../../common/utils/sizes.dart';
import '../../network/model/category.dart';
import '../progress/loading_horizontal_thumbnail.dart';

class CardCategory extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CardCategory({required this.category, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              child: Stack(
                children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(7)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black12,
                          ColorPalettes.black50,
                        ],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      child: CachedNetworkImage(
                        imageUrl: category.categoryImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            LoadingHorizontalThumbnail(),
                        errorWidget: (context, url, error) =>
                            LoadingHorizontalThumbnail(),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            category.categoryName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: ColorPalettes.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
