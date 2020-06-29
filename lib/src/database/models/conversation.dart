import 'package:tellam/src/database/models/message.dart';

class Conversation {
  String key;
  int agentId;
  int userId;
  bool isAssigned;
  bool isClosed;
  List<Message> messages;

  Conversation({
    this.key,
    this.agentId,
    this.userId,
    this.isAssigned,
    this.isClosed,
    this.messages,
  });
}
