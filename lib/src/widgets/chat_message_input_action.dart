import 'package:flutter/material.dart';
import 'package:tellam/src/view_models/tellam_chat_view_model.dart';
import 'package:tellam/tellam.dart';

class ChatMessageInputAction extends StatefulWidget {
  const ChatMessageInputAction({
    Key key,
    @required this.chatViewModel,
  }) : super(key: key);

  final ChatViewModel chatViewModel;

  @override
  _ChatMessageInputActionState createState() => _ChatMessageInputActionState();
}

class _ChatMessageInputActionState extends State<ChatMessageInputAction> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            minLines: 1,
            maxLines: 3,
            controller: widget.chatViewModel.messageTextEditingController,
            decoration: InputDecoration(
              hintText: "Write a reply...",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Tellam.uiConfiguration.accentColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Tellam.uiConfiguration.primaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ButtonTheme(
          minWidth: 60,
          height: 60,
          child: RaisedButton(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            onPressed: widget.chatViewModel.sendMessage,
            color: Tellam.uiConfiguration.accentColor,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
