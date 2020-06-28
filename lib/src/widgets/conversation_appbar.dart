import 'package:flutter/material.dart';
import 'package:tellam/src/widgets/oval_image.dart';

class ConversationAppbar extends StatelessWidget {
  const ConversationAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        OvalImage(),
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
