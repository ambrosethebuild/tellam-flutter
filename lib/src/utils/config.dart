import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: "config")
class Config {
  String secretKey;
  String databaseUrl;

  Config({
    @required this.secretKey,
    @required this.databaseUrl,
  });
}
