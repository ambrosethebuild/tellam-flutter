import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/tellam.dart';

class ConversationAppbar extends StatelessWidget {
  const ConversationAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        StreamBuilder<Company>(
          stream: Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
          builder: (context, snapshot) {
            return OvalImage(
              url: (snapshot.hasData) ? snapshot.data.photo : "",
            );
          },
        ),
        ButtonTheme(
          minWidth: 20,
          child: FlatButton(
            onPressed: () {
              //close the page
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
