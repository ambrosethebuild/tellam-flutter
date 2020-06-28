import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: "users")
class TellamUser {
  @primaryKey
  int id;
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  String photo;

  TellamUser({
    @required this.id,
    @required this.firstName,
    this.lastName = "",
    this.emailAddress = "",
    this.phoneNumber = "",
    this.photo = "",
  });
}
