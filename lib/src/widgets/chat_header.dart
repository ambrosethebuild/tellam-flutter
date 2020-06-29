import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/views/chat_page.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/tellam.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatHeader extends StatefulWidget {
  ChatHeader({
    Key key,
    this.conversation,
  }) : super(key: key);

  final Conversation conversation;

  @override
  _ChatHeaderState createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              conversation: widget.conversation,
            ),
          ),
        );
      },
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          StreamBuilder<Event>(
            stream: Tellam.tellamDatabaseReference
                .child("agents/${widget.conversation.agentId}")
                .onValue,
            builder: (context, event) {
              // final agentSnapshotValue = event.data.snapshot.value;
              //if there is no agent assigned to chat
              //use the company info instead of agent name
              if (!event.hasData || event.data.snapshot.value == null) {
                return StreamBuilder<Company>(
                  stream:
                      Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
                  builder: (context, snapshot) {
                    return OvalImage(
                      url: (snapshot.hasData) ? snapshot.data.photo : "",
                      height: 30,
                      weight: 30,
                    );
                  },
                );
              }

              //there is an agent asssignned to the chat/conversation
              //load the agent name and photo
              final agentSnapshotValue = event.data.snapshot.value;
              final mAgent = Agent(
                id: agentSnapshotValue["id"],
                firstName: agentSnapshotValue["first_name"],
                lastName: agentSnapshotValue["last_name"],
                emailAddress: agentSnapshotValue["email"],
                photo: agentSnapshotValue["photo"],
                phoneNumber: agentSnapshotValue["phone"],
                status: agentSnapshotValue["status"],
              );

              return OvalImage(
                url: mAgent.photo ?? "",
                height: 30,
                weight: 30,
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //listening to agent assigned to this conversation
                StreamBuilder<Event>(
                  stream: Tellam.tellamDatabaseReference
                      .child("agents/${widget.conversation.agentId}")
                      .onValue,
                  builder: (context, event) {
                    // final agentSnapshotValue = event.data.snapshot.value;
                    //if there is no agent assigned to chat
                    //use the company info instead of agent name
                    if (!event.hasData || event.data.snapshot.value == null) {
                      return StreamBuilder<Company>(
                        stream: Tellam.appDatabase.companyDao
                            .getCurrentCompanyStream(),
                        builder: (context, snapshot) {
                          return Text(
                            (snapshot.hasData) ? snapshot.data.name : "Agent",
                            style: TellamTextStyles.h6TitleTextStyle(),
                          );
                        },
                      );
                    }

                    //there is an agent asssignned to the chat/conversation
                    //load the agent name and photo
                    final agentSnapshotValue = event.data.snapshot.value;
                    final mAgent = Agent(
                      id: agentSnapshotValue["id"],
                      firstName: agentSnapshotValue["first_name"],
                      lastName: agentSnapshotValue["last_name"],
                      emailAddress: agentSnapshotValue["email"],
                      photo: agentSnapshotValue["photo"],
                      phoneNumber: agentSnapshotValue["phone"],
                      status: agentSnapshotValue["status"],
                    );

                    return Text(
                      mAgent.firstName,
                      style: TellamTextStyles.h6TitleTextStyle(),
                    );
                  },
                ),
                Text(
                  widget
                      .conversation
                      .messages[widget.conversation.messages.length - 1]
                      // .messages[0]
                      .message,
                  style: TellamTextStyles.h5TitleTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            timeago.format(
              DateTime.fromMillisecondsSinceEpoch(
                widget
                        .conversation
                        .messages[widget.conversation.messages.length - 1]
                        .timestamp
                        .toInt() *
                    1000,
              ),
              locale: 'en_short',
            ),
            style: TellamTextStyles.h6TitleTextStyle(),
          ),
        ],
      ),
    );
  }
}
