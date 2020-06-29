import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/tellam.dart';

class ChatViewModel {
  TextEditingController messageTextEditingController =
      new TextEditingController();

  ScrollController chatsScrollController = new ScrollController();

//behaviour subjects
  var _messages = BehaviorSubject<List<Message>>();
  var _agent = BehaviorSubject<Agent>();
  StreamSubscription<Event> chatQuery;
  StreamSubscription<Event> conversationAgentIdQuery;
  StreamSubscription<Event> agentQuery;

  //conversation model
  Conversation conversation;
  String newMessage;
  //stream getters
  Stream<List<Message>> get messages => _messages.stream;
  Stream<Agent> get agent => _agent.stream;

  void init() {
    startChatListening();
    startConversationAgentAssignmentListening();
  }

  void dispose() {
    _messages.close();
    _agent.close();
    chatsScrollController.dispose();
    if (chatQuery != null) {
      chatQuery.cancel();
    }
    if (conversationAgentIdQuery != null) {
      conversationAgentIdQuery.cancel();
    }
    if (agentQuery != null) {
      agentQuery.cancel();
    }
  }

  void startChatListening() async {
    //check if there was an existing conversation model
    if (conversation != null) {
      chatQuery = Tellam.tellamDatabaseReference
          .child("chats")
          .child(conversation.key)
          .child("messages")
          // .orderByChild("timestamp")
          .orderByKey()
          .onChildAdded
          .listen(
        (event) {
          final messageObject = event.snapshot.value;
          final mMessage = Message(
            isAgent: messageObject["is_agent"],
            read: messageObject["read"],
            message: messageObject["message"],
            timestamp: messageObject["timestamp"],
          );
          final mMessagesList = _messages.value ?? [];
          mMessagesList.add(mMessage);
          _messages.add(mMessagesList);

          //scroll to last message
          _scrollToBottom();
        },
        onError: (error) {
          print("Error Getting New Messages ==> $error");
        },
      );
    } else {
      print("Conversation not started yet");
    }
  }

  void startConversationAgentAssignmentListening() async {
    //check if there was an existing conversation model
    if (conversation != null) {
      conversationAgentIdQuery = Tellam.tellamDatabaseReference
          .child("chats")
          .child(conversation.key)
          .child("agent_id")
          .onValue
          .listen(
        (event) {
          //agent id details
          if (event.snapshot.value != null) {
            conversation.agentId = event.snapshot.value;
            startConversationAgentListening();
          } else {
            _agent.add(null);
          }
        },
        onError: (error) {
          print("Error Getting New Messages ==> $error");
        },
      );
    } else {
      print("Conversation not started yet");
    }
  }

  void startConversationAgentListening() async {
    //check if there was an existing conversation model
    if (conversation != null) {
      agentQuery = Tellam.tellamDatabaseReference
          .child("agents")
          .child("${conversation.agentId}")
          .onValue
          .listen(
        (event) {
          //agent details
          final agentObject = event.snapshot.value;
          final mAgent = Agent(
            id: agentObject["id"],
            firstName: agentObject["first_name"],
            lastName: agentObject["last_name"],
            emailAddress: agentObject["email"],
            photo: agentObject["photo"],
            phoneNumber: agentObject["phone"],
            status: agentObject["status"],
          );
          _agent.add(mAgent);
        },
        onError: (error) {
          print("Error Getting Agent Object ==> $error");
        },
      );
    } else {
      print("Conversation not started yet");
    }
  }

  void sendMessage({
    bool retrying = false,
  }) async {
    if (!retrying) {
      newMessage = messageTextEditingController.text;
      messageTextEditingController.text = "";
    }

    if (newMessage.isNotEmpty) {
      if (conversation != null) {
        //saving the message
        Tellam.tellamDatabaseReference
            .child("chats")
            .child(conversation.key)
            .child("messages")
            .push()
            .set(
          {
            "is_agent": 0,
            "message": newMessage,
            "read": 0,
            // "timestamp":
            //     (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).ceil(),
            "timestamp": DateTime.now().toUtc().millisecondsSinceEpoch,
          },
        );
      } else {
        //create new conversation, then save the mesaage to the conversation node
        final result = await createdNeedConversation();
        if (result) {
          print("About to resend message");
          sendMessage(
            retrying: true,
          );
        } else {
          print("Fail to create new conversation");
        }
      }
    } else {
      print("Empty message");
    }
  }

  Future<bool> createdNeedConversation() async {
    bool success = false;
    final currentUser = await Tellam.appDatabase.userDao.getCurrentUser();
    //retreive key for new conversation
    String conversationKey =
        Tellam.tellamDatabaseReference.child("chats").push().key;
    //set value for new conversation
    await Tellam.tellamDatabaseReference
        .child("chats")
        .child("$conversationKey")
        .set(
      {
        "is_assigned": false,
        "is_closed": false,
        "user_id": currentUser.id,
      },
    ).whenComplete(
      () {
        print("New conversation created");
        success = true;
      },
    ).catchError(
      (error) {
        print("Error saving conversation ===> $error");
        success = false;
      },
    );

    //if conversation was created successfully
    if (success) {
      //set the new conversation
      conversation = Conversation(
        key: conversationKey,
        isAssigned: false,
        isClosed: false,
        userId: currentUser.id,
      );

      //start listening to the newly created conversation
      startChatListening();
      startConversationAgentAssignmentListening();
    }

    //return operation status
    return success;
  }

  void _scrollToBottom() async {
    await Future.delayed(
      Duration(
        milliseconds: 500,
      ),
    );
    chatsScrollController.jumpTo(
      chatsScrollController.position.maxScrollExtent,
    );
  }

  //

}
