import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/utils/constants/k_assets.dart';
import '/utils/constants/k_colors.dart';

class CacheImage extends StatelessWidget {
  final double? height, width, roundCorner;
  final String? heroTag, initialsProfile;
  final String image;
  final BoxFit? fit;
  const CacheImage(
      {this.initialsProfile,
      required this.image,
      this.roundCorner,
      this.heroTag,
      this.height,
      this.width,
      super.key,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundCorner ?? 100),
        // border: dummyFallback!
        //     ? Border(
        //         bottom: BorderSide(
        //           width: 0.1,
        //           color: primaryTextGreyColor,
        //         ),
        //       )
        //     : null,
      ),
      width: width ?? 45,
      height: height ?? 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(roundCorner ?? 100),
        child: CachedNetworkImage(
          imageUrl: image,
          alignment: Alignment.center,
          fit: fit ?? BoxFit.cover,
          width: width ?? 45,
          height: height ?? 45,
          // placeholder: (context, url) {
          //   return Image.asset(
          //     KAssets.loadingGif,
          //     fit: BoxFit.cover,
          //   );
          // },
          progressIndicatorBuilder: (context, url, progress) {
            return Image.asset(
              KAssets.loadingGif,
              fit: BoxFit.cover,
            );
          },
          // cacheManager: ImageCacheService.instance.cacheManager,
          errorWidget: (context, url, error) {
            if (error.toString() == "Invalid image data") {}
            return ColoredBox(
              color: KColors.darkDarkGreyColor,
              child: Center(
                child: Text(
                  initialsProfile ?? image,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
            // return Initicon(
            //   text: initialsProfile ?? '',
            //   elevation: 4,
            // );
          },
        ),
      ),
    );
  }
}
