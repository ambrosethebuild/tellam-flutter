import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tellam/src/constants/tellam_assets.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/tellam.dart';

class ChatBannerTile extends StatefulWidget {
  ChatBannerTile({Key key}) : super(key: key);

  @override
  _ChatBannerTileState createState() => _ChatBannerTileState();
}

class _ChatBannerTileState extends State<ChatBannerTile> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey[400],
          width: 0.5,
        ),
        top: BorderSide(
          color: Colors.grey[400],
          width: 0.5,
        ),
      ),
      onPressed: () {
        print("Chat");
      },
      child: Row(
        children: <Widget>[
          ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  "https://storage.googleapis.com/snaptask/system/App%20Icon.png",
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
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                );
              },
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Live Chat",
                  style: TellamTextStyles.h4TitleTextStyle(
                    color: Tellam.uiConfiguration.primaryDarkColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Chat with us about your problem",
                  style: TellamTextStyles.h5TitleTextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
