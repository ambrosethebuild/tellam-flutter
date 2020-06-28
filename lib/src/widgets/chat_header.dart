import 'package:flutter/material.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/widgets/oval_image.dart';

class ChatHeader extends StatefulWidget {
  ChatHeader({Key key}) : super(key: key);

  @override
  _ChatHeaderState createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          OvalImage(
            height: 30,
            weight: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "snapTask",
                  style: TellamTextStyles.h6TitleTextStyle(),
                ),
                Text(
                  "hello",
                  style: TellamTextStyles.h5TitleTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "2 days ago",
            style: TellamTextStyles.h6TitleTextStyle(),
          ),
        ],
      ),
    );
  }
}
