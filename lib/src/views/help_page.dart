import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/src/database/models/state_data_model.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/view_models/tellam_help_view_model.dart';
import 'package:tellam/src/views/faq_details_page.dart';
import 'package:tellam/src/views/faq_topic_page.dart';
import 'package:tellam/src/widgets/chat_banner_tile.dart';
import 'package:tellam/src/widgets/data_loading_indicator.dart';
import 'package:tellam/src/widgets/faq_tile.dart';
import 'package:tellam/src/widgets/header_title_tile.dart';
import 'package:tellam/src/widgets/page_view_state.dart';
import 'package:tellam/src/widgets/powered_by.dart';
import 'package:tellam/tellam.dart';

class TellamHelpPage extends StatefulWidget {
  TellamHelpPage({Key key}) : super(key: key);

  @override
  _TellamHelpPageState createState() => _TellamHelpPageState();
}

class _TellamHelpPageState extends State<TellamHelpPage> {
  //FAQViewModel Instance
  TellamHelpViewModel _tellamHelpViewModel = TellamHelpViewModel();

  @override
  void initState() {
    super.initState();
    _tellamHelpViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tellam.uiConfiguration.primaryDarkColor,
        title: Text("Help & Faqs"),
      ),
      body: ListView(
        children: <Widget>[
          //Header tile
          HeaderTextTile(
            faqTopic: FAQTopic(
              topicId: 0,
              title: "Popular FAQ's",
            ),
            textStyle: TellamTextStyles.h4TitleTextStyle(),
          ),

          //Popular faq
          StreamBuilder<List<FAQ>>(
            stream: _tellamHelpViewModel.faqs,
            builder: (context, snapshot) {
              if ((!snapshot.hasData && !snapshot.hasError) ||
                  snapshot.data.length < 1) {
                return DataLoadingIndicator();
              } else if (snapshot.hasError) {
                final errorStateDataModel = StateDataModel();
                errorStateDataModel.iconData = Icons.sms_failed;
                errorStateDataModel.iconColor =
                    Tellam.uiConfiguration.primaryDarkColor;
                errorStateDataModel.title = "Connection Problem";
                errorStateDataModel.description =
                    "There was a connection problem getting requested data. Please try again later";
                return PageStateView(
                  stateDataModel: errorStateDataModel,
                );
              }

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return FAQTile(
                    faq: snapshot.data[index],
                    onPressed: () {
                      //show full faq details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQDetailsPage(
                            faq: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          // SizedBox(
          //   height: 20,
          // ),
          //Chat tile
          Tellam.showChat ? ChatBannerTile() : SizedBox.shrink(),

          //Header tile
          HeaderTextTile(
            faqTopic: FAQTopic(
              topicId: 0,
              title: "All Topics",
            ),
            textStyle: TellamTextStyles.h4TitleTextStyle(),
          ),

          //All FAQ topics
          StreamBuilder<List<FAQTopic>>(
            stream: _tellamHelpViewModel.faqTopics,
            builder: (context, snapshot) {
              if ((!snapshot.hasData && !snapshot.hasError) ||
                  snapshot.data.length < 1) {
                return DataLoadingIndicator();
              } else if (snapshot.hasError) {
                final errorStateDataModel = StateDataModel();
                errorStateDataModel.iconData = Icons.sms_failed;
                errorStateDataModel.iconColor =
                    Tellam.uiConfiguration.primaryDarkColor;
                errorStateDataModel.title = "Connection Problem";
                errorStateDataModel.description =
                    "There was a connection problem getting requested data. Please try again later";
                return PageStateView(
                  stateDataModel: errorStateDataModel,
                );
              }

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return HeaderTextTile(
                    faqTopic: snapshot.data[index],
                    textStyle: TellamTextStyles.h5TitleTextStyle(),
                    onPressed: () {
                      //show full faq details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQTopicPage(
                            faqTopic: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          //Powered by footer
          PoweredBy(),
        ],
      ),
    );
  }
}
