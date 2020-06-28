library tellam;

export 'package:tellam/src/database/models/tellam_user.dart';
export 'package:tellam/src/utils/ui_configuration.dart';

import 'package:flutter/material.dart';
import 'package:tellam/src/database/AppDatabase.dart';
import 'package:tellam/src/database/AppDatabaseSingleton.dart';
import 'package:tellam/src/utils/ui_configuration.dart';
import 'src/utils/client.dart';
import 'src/utils/config.dart';
import 'src/views/help_page.dart';

class Tellam {
  static UIConfiguration uiConfiguration;
  static Config config;
  static AppDatabase appDatabase;
  static bool showChat;

  //initialize with keys
  static initialize({
    @required String secretKey,
    @required String databaseUrl,
    UIConfiguration uiconfiguration,
  }) async {
    //save the keys for later reference
    config = Config(
      secretKey: secretKey,
      databaseUrl: databaseUrl,
    );
    uiConfiguration = uiconfiguration ?? UIConfiguration();

    //prepare database
    appDatabase = await AppDatabaseSingleton().database;
    // appDatabase.faqDao.deleteAllFAQs();
    // appDatabase.faqTopicDao.deleteAllFAQTopics();
    // appDatabase.dataUpdateDao.deleteAllDataUpdates();
  }

  //access to user dao class
  static Client client() => Client();

  //show the help/support page
  static show(
    BuildContext context, {
    bool enableChat = true,
  }) {
    //setting if the developer whats chat should be shown
    showChat = enableChat;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TellamHelpPage(),
      ),
    );
  }
}
