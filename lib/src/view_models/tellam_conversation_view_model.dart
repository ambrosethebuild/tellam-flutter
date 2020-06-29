import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/subjects.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/database/models/message.dart';
import 'package:tellam/tellam.dart';

class TellamConversationViewModel {
  //behaviour subjects
  var _agents = BehaviorSubject<List<Agent>>();
  var _recentConversations = BehaviorSubject<List<Conversation>>();
  //stream getters
  Stream<List<Agent>> get agents => _agents.stream;
  Stream<List<Conversation>> get recentConversations =>
      _recentConversations.stream;

  //check if faq/faqtopics need to be updated
  void init() async {
    //start listening to company agents
    _getCompanyAgents();
    //start listening to recent conversations
    _getRecentConversations();
  }

  void dispose() {
    _agents.close();
    _recentConversations.close();
  }

  //get company agents
  void _getCompanyAgents() async {
    Tellam.tellamDatabaseReference
        .child("agents")
        .limitToFirst(6)
        .onValue
        .listen(
      (event) {
        //map the agent dynamic list to list of agent model
        List<Agent> mAgents = [];

        (event.snapshot.value as Map<dynamic, dynamic>).forEach(
          (key, agentObject) {
            final mAgent = Agent(
              id: agentObject["id"],
              firstName: agentObject["first_name"],
              lastName: agentObject["last_name"],
              emailAddress: agentObject["email"],
              photo: agentObject["photo"],
              phoneNumber: agentObject["phone"],
              status: agentObject["status"],
            );

            mAgents.add(mAgent);
          },
        );

        _agents.add(mAgents);
      },
      onError: (errorSnapshot) {
        print("Error Snapshot ===> $errorSnapshot");
        _agents.addError(errorSnapshot);
      },
    );
  }

  //get recent chats
  void _getRecentConversations() async {
    final currentTellamUser = await Tellam.appDatabase.userDao.getCurrentUser();

    //handle when object in the user chat changes
    Tellam.tellamDatabaseReference
        .child("chats")
        .orderByChild("user_id")
        .equalTo(currentTellamUser.id)
        .limitToLast(5)
        .onChildChanged
        .listen(
      (event) {
        //check if messages is available in the conversation
        if (event.snapshot.value["messages"] != null) {
          //conversation object from firebase
          final conversationObject = event.snapshot.value;
          //load basic info
          final mConversation = Conversation(
            key: event.snapshot.key,
            agentId: conversationObject["agent_id"],
            userId: conversationObject["user_id"],
            isAssigned: conversationObject["is_assigned"],
            isClosed: conversationObject["is_closed"] ?? false,
            messages: [],
          );

          //Load conversation messages
          Map<String, dynamic> conversationMessages =
              Map.from(event.snapshot.value["messages"]);
          conversationMessages.values.forEach(
            (messageObject) {
              final mMessage = Message(
                isAgent: messageObject["is_agent"],
                read: messageObject["read"],
                message: messageObject["message"],
                timestamp: messageObject["timestamp"],
              );
              mConversation.messages.add(mMessage);
            },
          );

          final mConversations = _recentConversations.value ?? [];
          final updateIndex = mConversations.indexWhere(
              (conversation) => conversation.key == mConversation.key);
          if (updateIndex >= 0) {
            mConversations.removeAt(updateIndex);
            mConversations.insert(updateIndex, mConversation);
          } else {
            mConversations.add(mConversation);
          }
          _recentConversations.add(mConversations);
        }
      },
      onError: (errorSnapshot) {
        print("Error Snapshot ===> $errorSnapshot");
        _recentConversations.addError(errorSnapshot);
      },
    );

    //when object is added to chats node
    Tellam.tellamDatabaseReference
        .child("chats")
        .orderByChild("user_id")
        .equalTo(currentTellamUser.id)
        .limitToLast(5)
        // .onChildAdded
        .onChildAdded
        .listen(
      (event) {
        //only read conversation that contains messages
        if (event.snapshot.value["messages"] != null) {
          parseConversationToStream(event.snapshot);
        }
      },
      onError: (errorSnapshot) {
        print("Error Snapshot ===> $errorSnapshot");
        _recentConversations.addError(errorSnapshot);
      },
    );
  }

  //convert the conversation data from firebase object to mdoel
  //then add it to the stream
  void parseConversationToStream(DataSnapshot snapshot) {
    //conversation object from firebase
    final conversationObject = snapshot.value;
    //load basic info
    final conversation = Conversation(
      key: snapshot.key,
      agentId: conversationObject["agent_id"],
      userId: conversationObject["user_id"],
      isAssigned: conversationObject["is_assigned"],
      isClosed: conversationObject["is_closed"] ?? false,
      messages: [],
    );

    //Load conversation messages
    Map<String, dynamic> conversationMessages =
        Map.from(snapshot.value["messages"]);
    conversationMessages.values.forEach(
      (messageObject) {
        final mMessage = Message(
          isAgent: messageObject["is_agent"],
          read: messageObject["read"],
          message: messageObject["message"],
          timestamp: messageObject["timestamp"],
        );
        conversation.messages.add(mMessage);
      },
    );

    final mConversations = _recentConversations.value ?? [];
    mConversations.add(conversation);
    _recentConversations.add(mConversations);
  }
}
