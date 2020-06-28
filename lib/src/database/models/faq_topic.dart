import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: "faq_topics")
class FAQTopic {
  @PrimaryKey(autoGenerate: true)
  int id;
  int topicId;
  String title;

  FAQTopic({
    @required this.topicId,
    @required this.title,
  });
}
