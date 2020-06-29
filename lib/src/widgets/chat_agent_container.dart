import 'package:flutter/material.dart';
import 'package:tellam/src/database/models/agent.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/view_models/tellam_chat_view_model.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/tellam.dart';

class ChatAgentContainer extends StatelessWidget {
  const ChatAgentContainer({
    Key key,
    @required this.chatViewModel,
  }) : super(key: key);

  final ChatViewModel chatViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Tellam.uiConfiguration.primaryDarkColor,
      child: StreamBuilder<Agent>(
          stream: chatViewModel.agent,
          builder: (context, agentSnapshot) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //close chat button
                ButtonTheme(
                  minWidth: 30,
                  height: 30,
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //agent profile photo
                (!agentSnapshot.hasData)
                    ? StreamBuilder<Company>(
                        stream: Tellam.appDatabase.companyDao
                            .getCurrentCompanyStream(),
                        builder: (context, snapshot) {
                          return OvalImage(
                            url: (snapshot.hasData) ? snapshot.data.photo : "",
                          );
                        },
                      )
                    : OvalImage(
                        url: agentSnapshot.data.photo ?? "",
                      ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //agent name / company name
                    (agentSnapshot.hasData)
                        ? Text(
                            "${agentSnapshot.data.firstName} ${agentSnapshot.data.lastName}",
                            style: TellamTextStyles.h4TitleTextStyle(
                              color: Colors.white,
                            ),
                          )
                        : StreamBuilder<Company>(
                            stream: Tellam.appDatabase.companyDao
                                .getCurrentCompanyStream(),
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data.name,
                                style: TellamTextStyles.h4TitleTextStyle(
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    //Company intro
                    StreamBuilder<Company>(
                      stream: Tellam.appDatabase.companyDao
                          .getCurrentCompanyStream(),
                      builder: (context, snapshot) {
                        return Text(
                          (snapshot.hasData)
                              ? snapshot.data.replyTime
                              : "Typically replies with a day",
                          style: TellamTextStyles.h6TitleTextStyle(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
