import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq_topic.dart';
import 'package:tellam/src/utils/app_text_styles.dart';

class HeaderTextTile extends StatelessWidget {
  const HeaderTextTile({
    Key key,
    this.faqTopic,
    this.textStyle,
    this.padding = 20,
    this.onPressed,
  }) : super(key: key);

  final FAQTopic faqTopic;
  final TextStyle textStyle;
  final double padding;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      padding: EdgeInsets.all(this.padding),
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey[400],
          width: 0.5,
        ),
        top: BorderSide(
          color: Colors.grey[400],
          width: 0.5,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          this.faqTopic.title,
          textAlign: TextAlign.start,
          style: this.textStyle ??
              TellamTextStyles.h3TitleTextStyle(
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
