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

  @ignore
  dynamic getMappedObject() {
    return {
      "id": this.id,
      "first_name": this.firstName,
      "last_name": this.lastName ?? "",
      "email": this.emailAddress ?? "",
      "phone": this.phoneNumber ?? "",
      "photo": this.photo ?? "",
    };
  }
}
