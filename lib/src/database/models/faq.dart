import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: "faqs")
class FAQ {
  @PrimaryKey(autoGenerate: true)
  int id;
  int topicId;
  String title;
  String body;

  FAQ({
    this.id,
    @required this.topicId,
    @required this.title,
    @required this.body,
  });
}
