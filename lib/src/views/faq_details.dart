import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/tellam.dart';

class FAQDetailsPage extends StatefulWidget {
  FAQDetailsPage({
    Key key,
    this.faq,
  }) : super(key: key);

  final FAQ faq;

  @override
  _FAQDetailsPageState createState() => _FAQDetailsPageState();
}

class _FAQDetailsPageState extends State<FAQDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tellam.uiConfiguration.primaryDarkColor,
        title: Text(widget.faq.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(
            widget.faq.title,
            style: TellamTextStyles.h4TitleTextStyle(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.faq.body,
            style: TellamTextStyles.h5TitleTextStyle(),
          ),
        ],
      ),
    );
  }
}
