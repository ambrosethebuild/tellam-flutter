import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/tellam.dart';

class ChatViewModel {
  TextEditingController messageTextEditingController =
      new TextEditingController();

  ScrollController chatsScrollController = new ScrollController();

//behaviour subjects
  var _messages = BehaviorSubject<List<Message>>();

  //conversation model
  Conversation conversation;
  String newMessage;
  //stream getters
  Stream<List<Message>> get messages => _messages.stream;

  void dispose() {
    _messages.close();
  }

  void startChatListening() async {
    //check if there was an existing conversation model
    if (conversation != null) {
      Tellam.tellamDatabaseReference
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
          chatsScrollController.jumpTo(
            // chatsScrollController.position.maxScrollExtent,
            chatsScrollController.position.maxScrollExtent,
          );
        },
        onError: (error) {
          print("Error Getting New Messages ==> $error");
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
      print("Sending Message");
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
        ;
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
    }

    //return operation status
    return success;
  }

  //

}
