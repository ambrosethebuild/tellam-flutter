import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/faq.dart';
import 'package:tellam/src/utils/app_text_styles.dart';

class FAQTile extends StatelessWidget {
  const FAQTile({
    Key key,
    this.faq,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.onPressed,
  }) : super(key: key);

  final FAQ faq;
  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey[400],
          width: 0.5,
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              this.faq.title,
              style: this.titleTextStyle ??
                  TellamTextStyles.h5TitleTextStyle(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              this.faq.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: this.bodyTextStyle ??
                  TellamTextStyles.h5TitleTextStyle(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
