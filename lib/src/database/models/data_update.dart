import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: "updates")
class DataUpdate {
  @PrimaryKey(autoGenerate: true)
  int id;
  String model;
  String timestamp;

  DataUpdate({
    this.id,
    @required this.model,
    @required this.timestamp,
  });
}
