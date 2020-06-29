import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/utils/date_time_utils.dart';
import 'package:tellam/tellam.dart';

class UserMessageTile extends StatefulWidget {
  UserMessageTile({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  _UserMessageTileState createState() => _UserMessageTileState();
}

class _UserMessageTileState extends State<UserMessageTile> {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(
        top: 10,
        right: 10,
        left: 100,
      ),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      color: Tellam.uiConfiguration.userMessageBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            widget.message.message,
            textAlign: TextAlign.right,
            style: TellamTextStyles.h5TitleTextStyle(),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            DateTimeUtils.formatTimestamp(
              widget.message.timestamp.toInt(),
            ),
            textAlign: TextAlign.right,
            style: TellamTextStyles.h7TitleTextStyle(),
          ),
        ],
      ),
    );
  }
}
