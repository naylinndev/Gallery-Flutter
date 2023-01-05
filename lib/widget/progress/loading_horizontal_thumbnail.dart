import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../common/styles/color_palettes.dart';
import '../../common/utils/image_assets.dart';
import '../../common/utils/sizes.dart';

class LoadingHorizontalThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dp5(context))),
          child: Container(
            color: ColorPalettes.grey,
            padding: EdgeInsets.all(12),
            child: Image.asset(ImagesAssets.horizontalThumbnailIcon,
                fit: BoxFit.cover, width: Sizes.width(context)),
          ),
        ));
  }
}
