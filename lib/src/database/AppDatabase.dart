import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tellam/src/database/dao/company_dao.dart';
import 'package:tellam/src/database/dao/data_update_dao.dart';
import 'package:tellam/src/database/dao/faq_dao.dart';
import 'package:tellam/src/database/dao/faq_topic_dao.dart';
import 'package:tellam/src/database/dao/user_dao.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/database/models/data_update.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/src/database/models/tellam_user.dart';

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  TellamUser,
  FAQ,
  FAQTopic,
  DataUpdate,
  Company,
])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  FAQDao get faqDao;
  FAQTopicDao get faqTopicDao;
  CompanyDao get companyDao;
  DataUpdateDao get dataUpdateDao;
}
