import 'package:flutter/foundation.dart';

class Agent {
  int id;
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  String photo;
  int status;

  Agent({
    @required this.id,
    @required this.firstName,
    this.lastName = "",
    this.emailAddress = "",
    this.phoneNumber = "",
    this.photo = "",
    this.status = 0,
  });
}
