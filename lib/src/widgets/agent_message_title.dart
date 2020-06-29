import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/utils/date_time_utils.dart';
import 'package:tellam/tellam.dart';

class AgentMessageTile extends StatefulWidget {
  AgentMessageTile({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  _AgentMessageTileState createState() => _AgentMessageTileState();
}

class _AgentMessageTileState extends State<AgentMessageTile> {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(
        top: 10,
        left: 10,
        right: 100,
      ),
      alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      color: Tellam.uiConfiguration.agentMessageBackgroundColor,
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
