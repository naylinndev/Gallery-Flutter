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
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              width: Sizes.width(context),
              child: Stack(
                children: [
                  Container(
                    height: 450,
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
                        width: Sizes.width(context),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            LoadingHorizontalThumbnail(),
                        errorWidget: (context, url, error) =>
                            LoadingHorizontalThumbnail(),
                      ),
                    ),
                  ),
                  Container(
                    height: 450,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Text(
                            category.categoryName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 23,
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
