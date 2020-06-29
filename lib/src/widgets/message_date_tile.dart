import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class MessageDateTile extends StatefulWidget {
  MessageDateTile({
    Key key,
    this.date,
  }) : super(key: key);

  final String date;

  @override
  _MessageDateTileState createState() => _MessageDateTileState();
}

class _MessageDateTileState extends State<MessageDateTile> {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      stick: true,
      margin: BubbleEdges.only(
        top: 10,
        bottom: 10,
      ),
      alignment: Alignment.center,
      color: Color.fromRGBO(212, 234, 244, 1.0),
      child: Text(
        widget.date,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.0,
        ),
      ),
    );
  }
}
