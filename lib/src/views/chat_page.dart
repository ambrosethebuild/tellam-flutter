import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/src/utils/date_time_utils.dart';
import 'package:tellam/src/view_models/tellam_chat_view_model.dart';
import 'package:tellam/src/widgets/agent_message_title.dart';
import 'package:tellam/src/widgets/chat_agent_container.dart';
import 'package:tellam/src/widgets/chat_appbar.dart';
import 'package:tellam/src/widgets/chat_message_input_action.dart';
import 'package:tellam/src/widgets/message_date_tile.dart';
import 'package:tellam/src/widgets/user_message_title.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    Key key,
    this.conversation,
  }) : super(key: key);

  final Conversation conversation;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //ChatViewModel Instance
  ChatViewModel _chatViewModel = new ChatViewModel();

  @override
  void initState() {
    super.initState();

    //setting the conversation model to be used in the messaging
    _chatViewModel.conversation = widget.conversation;
    _chatViewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    _chatViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        child: SizedBox.shrink(),
      ),
      body: Stack(
        children: <Widget>[
          //Agent Info
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 80,
            child: ChatAgentContainer(
              chatViewModel: _chatViewModel,
            ),
          ),
          //messages listview
          Positioned(
            left: 0,
            right: 0,
            bottom:
                (widget.conversation != null && !widget.conversation.isClosed)
                    ? 100
                    : 0,
            top: 80,
            child: StreamBuilder<List<Message>>(
                stream: _chatViewModel.messages,
                builder: (context, snapshot) {
                  //get the data sent through stream
                  //if there was not message, create empty array
                  final messages = snapshot.data ?? [];
                  int previousMessageTimeStamp;

                  return ListView.separated(
                    controller: _chatViewModel.chatsScrollController,
                    padding: EdgeInsets.only(
                      bottom: 100,
                    ),
                    itemBuilder: (context, index) {
                      Widget messageTile;

                      if (messages[index].isAgent == 1) {
                        messageTile = AgentMessageTile(
                          message: messages[index],
                        );
                      } else {
                        messageTile = UserMessageTile(
                          message: messages[index],
                        );
                      }

                      var messageDate;
                      //prevent show same message date twice
                      if (previousMessageTimeStamp != null &&
                          DateTimeUtils.isSameDay(
                            previousMessageTimeStamp,
                            messages[index].timestamp,
                          )) {
                      }
                      //show the message date is no previous message date
                      else {
                        messageDate = DateTimeUtils.formatTimestamp(
                          messages[index].timestamp,
                          outputFormat: "EE dd MMM, yyyy",
                        );
                      }

                      //store the current timestamp to be used in the next loop
                      previousMessageTimeStamp = messages[index].timestamp;

                      return Column(
                        children: <Widget>[
                          (messageDate != null)
                              ? MessageDateTile(
                                  date: messageDate,
                                )
                              : SizedBox.shrink(),
                          messageTile,
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: messages.length,
                  );
                }),
          ),
          //Send message widget
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child:
                //Hide the message entry box if conversation has close
                (widget.conversation == null || !widget.conversation.isClosed)
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        color: Colors.grey[100],
                        child: SafeArea(
                          bottom: true,
                          child: ChatMessageInputAction(
                            chatViewModel: _chatViewModel,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
