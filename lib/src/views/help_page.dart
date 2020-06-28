import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/view_models/faq_view_model.dart';
import 'package:tellam/src/views/faq_details.dart';
import 'package:tellam/src/widgets/chat_banner_tile.dart';
import 'package:tellam/src/widgets/faq_tile.dart';
import 'package:tellam/src/widgets/header_title_tile.dart';
import 'package:tellam/src/widgets/powered_by.dart';
import 'package:tellam/tellam.dart';

class TellamHelpPage extends StatefulWidget {
  TellamHelpPage({Key key}) : super(key: key);

  @override
  _TellamHelpPageState createState() => _TellamHelpPageState();
}

class _TellamHelpPageState extends State<TellamHelpPage> {
  //FAQViewModel Instance
  FAQViewModel _faqViewModel = FAQViewModel();

  @override
  void initState() {
    super.initState();
    _faqViewModel.init();
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
            stream: _faqViewModel.faqs,
            builder: (context, snapshot) {
              if ((!snapshot.hasData && !snapshot.hasError) ||
                  snapshot.data.length < 1) {
                return Text("Loading");
              } else if (snapshot.hasError) {
                return Text("Error");
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
          ChatBannerTile(),

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
            stream: _faqViewModel.faqTopics,
            builder: (context, snapshot) {
              if ((!snapshot.hasData && !snapshot.hasError) ||
                  snapshot.data.length < 1) {
                return Text("Loading");
              } else if (snapshot.hasError) {
                return Text("Error");
              }

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return HeaderTextTile(
                    faqTopic: snapshot.data[index],
                    textStyle: TellamTextStyles.h5TitleTextStyle(),
                    onPressed: () {},
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
