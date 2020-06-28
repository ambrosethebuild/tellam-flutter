import 'package:floor/floor.dart';

@Entity(tableName: "companies")
class Company {
  @primaryKey
  String name;
  String photo;
  String background;
  String chatIntro;
  String description;

  Company({
    this.name,
    this.photo,
    this.background,
    this.chatIntro,
    this.description,
  });
}
