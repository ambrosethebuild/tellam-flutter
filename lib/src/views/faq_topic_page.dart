import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/src/views/faq_details_page.dart';
import 'package:tellam/src/widgets/faq_tile.dart';
import 'package:tellam/tellam.dart';

class FAQTopicPage extends StatefulWidget {
  FAQTopicPage({
    Key key,
    this.faqTopic,
  }) : super(key: key);

  final FAQTopic faqTopic;

  @override
  _FAQTopicPageState createState() => _FAQTopicPageState();
}

class _FAQTopicPageState extends State<FAQTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tellam.uiConfiguration.primaryDarkColor,
        title: Text(widget.faqTopic.title),
      ),
      body: StreamBuilder<List<FAQ>>(
        stream:
            Tellam.appDatabase.faqDao.findByTopicId(widget.faqTopic.topicId),
        builder: (context, snapshot) {
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
    );
  }
}
