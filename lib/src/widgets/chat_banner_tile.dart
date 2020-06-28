import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/views/conversation_page.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/tellam.dart';

class ChatBannerTile extends StatefulWidget {
  ChatBannerTile({Key key}) : super(key: key);

  @override
  _ChatBannerTileState createState() => _ChatBannerTileState();
}

class _ChatBannerTileState extends State<ChatBannerTile> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationPage(),
          ),
        );
      },
      child: Row(
        children: <Widget>[
          StreamBuilder<Company>(
            stream: Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
            builder: (context, snapshot) {
              return OvalImage(
                url: (snapshot.hasData) ? snapshot.data.photo : "",
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Live Chat",
                  style: TellamTextStyles.h4TitleTextStyle(
                    color: Tellam.uiConfiguration.primaryDarkColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                StreamBuilder<Company>(
                  stream:
                      Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
                  builder: (context, snapshot) {
                    return Text(
                      (snapshot.hasData)
                          ? snapshot.data.chatIntro
                          : "Chat with us about your problem",
                      style: TellamTextStyles.h5TitleTextStyle(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
