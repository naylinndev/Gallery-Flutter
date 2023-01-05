import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery/network/model/photo.dart';
import '../../common/styles/color_palettes.dart';
import '../../common/utils/image_assets.dart';
import '../../common/utils/sizes.dart';
import '../progress/loading_horizontal_thumbnail.dart';

class CardPhoto extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  const CardPhoto({required this.photo, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkTheme = theme.appBarTheme.backgroundColor == null;
    var width = Sizes.width(context) / 3 - 10;
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
              margin: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Image
                  Stack(
                    children: [
                      Container(
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.dp5(context))),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorPalettes.black50,
                              ColorPalettes.black50,
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.dp5(context))),
                          child: CachedNetworkImage(
                            imageUrl:
                                photo.image,
                            width: Sizes.width(context),
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                LoadingHorizontalThumbnail(),
                            errorWidget: (context, url, error) =>
                                LoadingHorizontalThumbnail(),
                          ),
                        ),
                      ),

                    ],
                  ),
                  // Text and Rating
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.dp10(context))),
                    ),
                    padding: EdgeInsets.only(
                        left: Sizes.dp6(context), bottom: Sizes.dp5(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Text(
                          photo.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: ColorPalettes.black),
                        ),
                        Text(
                          photo.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 11,
                              color: ColorPalettes.secondaryColor),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
