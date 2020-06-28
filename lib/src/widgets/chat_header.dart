import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/tellam.dart';

class ChatHeader extends StatefulWidget {
  ChatHeader({Key key}) : super(key: key);

  @override
  _ChatHeaderState createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: <Widget>[
          StreamBuilder<Company>(
            stream: Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
            builder: (context, snapshot) {
              return OvalImage(
                url: (snapshot.hasData) ? snapshot.data.photo : "",
                height: 30,
                weight: 30,
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "snapTask",
                  style: TellamTextStyles.h6TitleTextStyle(),
                ),
                Text(
                  "hello",
                  style: TellamTextStyles.h5TitleTextStyle(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "2 days ago",
            style: TellamTextStyles.h6TitleTextStyle(),
          ),
        ],
      ),
    );
  }
}
