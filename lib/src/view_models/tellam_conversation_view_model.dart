import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/subjects.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/tellam.dart';

class TellamConversationViewModel {
  //behaviour subjects
  var _agents = BehaviorSubject<List<Agent>>();
  var _recentConversations = BehaviorSubject<List<Conversation>>();
  //stream getters
  Stream<List<Agent>> get agents => _agents.stream;
  Stream<List<Conversation>> get recentConversations =>
      _recentConversations.stream;

  //tellam database reference
  DatabaseReference tellamDatabaseReference;

  //check if faq/faqtopics need to be updated
  void init() async {
    tellamDatabaseReference = FirebaseDatabase(
      databaseURL: Tellam.config.databaseUrl,
    ).reference();

    //start listening to company agents
    _getCompanyAgents();
  }

  void dispose() {
    _agents.close();
    _recentConversations.close();
  }

  //get company agents
  void _getCompanyAgents() async {
    tellamDatabaseReference.child("agents").limitToFirst(5).onValue.listen(
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
}
