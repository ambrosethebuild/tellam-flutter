import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tellam/src/constants/tellam_assets.dart';

class OvalImage extends StatelessWidget {
  const OvalImage({
    Key key,
    this.height,
    this.weight,
    this.url,
  }) : super(key: key);

  final double height;
  final double weight;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: this.url,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return CircularProgressIndicator(
            value: downloadProgress.progress,
          );
        },
        errorWidget: (context, url, error) {
          return Image(
            image: AssetImage(
              TellamAssets.defaultCompanyAvatarAsset,
              package: "tellam",
            ),
            width: this.weight ?? 50,
            height: this.height ?? 50,
            fit: BoxFit.contain,
          );
        },
        fit: BoxFit.cover,
        width: this.weight ?? 50,
        height: this.height ?? 50,
      ),
    );
  }
}
