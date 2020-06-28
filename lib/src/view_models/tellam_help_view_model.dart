import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/database/models/data_update.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/tellam.dart';

class TellamHelpViewModel {
  //stream getters
  Stream<List<FAQ>> get faqs => Tellam.appDatabase.faqDao.findPopularStream();
  Stream<List<FAQTopic>> get faqTopics =>
      Tellam.appDatabase.faqTopicDao.findAllStream();

  //tellam database reference
  DatabaseReference tellamDatabaseReference;

  //check if faq/faqtopics need to be updated
  void init() async {
    tellamDatabaseReference = FirebaseDatabase(
      databaseURL: Tellam.config.databaseUrl,
    ).reference();

    //checking if we need to update data
    final updateTimestamp = await firebaseUpdateTimestamp();
    DataUpdate dataUpdate = await Tellam.appDatabase.dataUpdateDao.findLast();
    if (dataUpdate == null ||
        int.parse(dataUpdate.timestamp) < updateTimestamp) {
      print("Need to update data");

      //update the faqs
      await updateFAQS(
        updateTimestamp: updateTimestamp,
      );

      //update the faq topics
      await updateFAQTopics(
        updateTimestamp: updateTimestamp,
      );

      //update company info
      await updateCompanyInfo(
        updateTimestamp: updateTimestamp,
      );
    } else {
      print("No Need to update data");
    }
  }

  void dispose() {}

  //get the update timestamp from firebase
  Future<int> firebaseUpdateTimestamp() async {
    int updateTimestamp = 0;
    //listen to timestamp update on the server
    await tellamDatabaseReference.child("update_timestamp").once().then(
      (dataSnapshot) {
        updateTimestamp = dataSnapshot.value;
      },
      onError: (error) {
        print("Error getting update timestamp ==> $error");
      },
    );
    return updateTimestamp;
  }

  //fetch faqs from firebase and save to local database
  Future<bool> updateFAQS({@required int updateTimestamp}) async {
    bool success;
    List<FAQ> faqs = [];

    //fetch faqs from firebase database
    await tellamDatabaseReference.child("faqs").once().then(
      (dataSnapshot) {
        //convert the value to map/array
        Map<String, dynamic> faqsArray = Map.from(dataSnapshot.value);
        faqsArray.values.forEach(
          (faqObject) {
            //parse the object to faq model
            final faq = FAQ(
              topicId: int.parse(
                faqObject["topic-id"].toString(),
              ),
              title: faqObject["title"],
              body: faqObject["body"],
            );

            //append faq to list for mass insert
            faqs.add(faq);
          },
        );

        success = true;
      },
      onError: (error) {
        print("Error getting faqs ==> $error");
        success = false;
      },
    );

    if (success) {
      //saving the faq models
      Tellam.appDatabase.faqDao.replaceFAQs(
        faqs,
      );
      //prepare faq data update model
      final dataUpdate = DataUpdate(
        model: "faqs",
        timestamp: updateTimestamp.toString(),
      );

      //saving the faq data update timestamp
      Tellam.appDatabase.dataUpdateDao.insertDataUpdate(
        dataUpdate,
      );
    }

    return success;
  }

  //fetch faq topics from firebase and save to local database
  Future<bool> updateFAQTopics({@required int updateTimestamp}) async {
    bool success;
    List<FAQTopic> faqTopics = [];

    //fetch faqs from firebase database
    await tellamDatabaseReference.child("faqs-topics").once().then(
      (dataSnapshot) {
        print("FAQ Topics ==> ${dataSnapshot.value}");
        //convert the value to map/array
        List<dynamic> faqTopicsArray = dataSnapshot.value;
        faqTopicsArray.forEach(
          (faqObject) {
            //parse the object to faq model
            final faqTopic = FAQTopic(
              topicId: faqObject["id"],
              title: faqObject["name"],
            );

            //append faq topics to list for mass insert
            faqTopics.add(faqTopic);
          },
        );

        success = true;
      },
      onError: (error) {
        print("Error getting faqs ==> $error");
        success = false;
      },
    );

    if (success) {
      //saving the faq models
      Tellam.appDatabase.faqTopicDao.replaceFAQTopics(
        faqTopics,
      );

      //prepare faq data update model
      final dataUpdate = DataUpdate(
        model: "faq_topics",
        timestamp: updateTimestamp.toString(),
      );

      //saving the faq data update timestamp
      Tellam.appDatabase.dataUpdateDao.insertDataUpdate(
        dataUpdate,
      );
    }

    return success;
  }

  //fetch comapny info from firebase and save to local database
  Future<bool> updateCompanyInfo({@required int updateTimestamp}) async {
    bool success;
    Company company;

    //fetch faqs from firebase database
    await tellamDatabaseReference.child("company").once().then(
      (dataSnapshot) {
        print("Company ==> ${dataSnapshot.value}");
        //convert the value to map/array
        final companyObject = dataSnapshot.value;
        company = Company(
          name: companyObject["name"],
          description: companyObject["description"],
          background: companyObject["background"],
          photo: companyObject["photo"],
          chatIntro: companyObject["chat_intro"],
        );
        success = true;
      },
      onError: (error) {
        print("Error getting company info ==> $error");
        success = false;
      },
    );

    if (success) {
      //saving the faq models
      Tellam.appDatabase.companyDao.insertCompany(
        company,
      );

      //prepare faq data update model
      final dataUpdate = DataUpdate(
        model: "companies",
        timestamp: updateTimestamp.toString(),
      );

      //saving the faq data update timestamp
      Tellam.appDatabase.dataUpdateDao.insertDataUpdate(
        dataUpdate,
      );
    }

    return success;
  }
}
