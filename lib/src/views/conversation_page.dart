import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tellam/src/database/models/company.dart';
import 'package:tellam/src/database/models/conversation.dart';
import 'package:tellam/src/database/models/state_data_model.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/view_models/tellam_conversation_view_model.dart';
import 'package:tellam/src/views/chat_page.dart';
import 'package:tellam/src/widgets/chat_header.dart';
import 'package:tellam/src/widgets/company_agents.dart';
import 'package:tellam/src/widgets/conversation_appbar.dart';
import 'package:tellam/src/widgets/data_loading_indicator.dart';
import 'package:tellam/src/widgets/page_view_state.dart';
import 'package:tellam/src/widgets/powered_by.dart';
import 'package:tellam/tellam.dart';

class ConversationPage extends StatefulWidget {
  ConversationPage({Key key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  //TellamConversationViewModel Instance
  TellamConversationViewModel _tellamConversationViewModel =
      TellamConversationViewModel();
  TellamUser tellamUser;

  @override
  void initState() {
    super.initState();
    _tellamConversationViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Backgorund SVG
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.40,
            child: StreamBuilder<Company>(
              stream: Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
              builder: (context, snapshot) {
                //gradient background
                final conversationBackground = Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: GradientColors.teal,
                    ),
                  ),
                );

                if (!snapshot.hasData ||
                    snapshot.hasError ||
                    snapshot.data.background.isEmpty) {
                  return conversationBackground;
                }

                return SvgPicture.network(
                  (snapshot.hasData) ? snapshot.data.background : '',
                  semanticsLabel: 'tellam',
                  fit: BoxFit.cover,
                  placeholderBuilder: (BuildContext context) {
                    return conversationBackground;
                  },
                );
              },
            ),
          ),

          //Content
          Positioned(
            top: 50,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                //Custom Appbar
                ConversationAppbar(),
                SizedBox(
                  height: 20,
                ),
                //Intro message
                StreamBuilder<TellamUser>(
                    stream: Tellam.appDatabase.userDao.getCurrentUserStream(),
                    builder: (context, snapshot) {
                      final firstName =
                          (snapshot.hasData) ? snapshot.data.firstName : "";
                      return Text(
                        "Hi $firstName 👋",
                        style: TellamTextStyles.h1TitleTextStyle(
                          color: Colors.white,
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                //Company intro
                StreamBuilder<Company>(
                  stream:
                      Tellam.appDatabase.companyDao.getCurrentCompanyStream(),
                  builder: (context, snapshot) {
                    return Text(
                      (snapshot.hasData)
                          ? snapshot.data.chatIntro
                          : "How can we help you today?",
                      style: TellamTextStyles.h5TitleTextStyle(
                        color: Colors.white,
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 30,
                ),
                //Conversation card

                Card(
                  elevation: 4,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Text(
                        "Your conversation(s)",
                        style: TellamTextStyles.h5TitleTextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<Company>(
                          stream: Tellam.appDatabase.companyDao
                              .getCurrentCompanyStream(),
                          builder: (context, snapshot) {
                            final replyTime = (snapshot.hasData)
                                ? snapshot.data.replyTime
                                : "Typically replies in a few hours";
                            return Text(
                              replyTime,
                              style: TellamTextStyles.h6TitleTextStyle(),
                            );
                          }),

                      //company agents
                      SizedBox(
                        height: 10,
                      ),

                      CompanyAgents(
                        tellamConversationViewModel:
                            _tellamConversationViewModel,
                      ),
                      //recent conversations
                      SizedBox(
                        height: 20,
                      ),

                      StreamBuilder<List<Conversation>>(
                        stream:
                            _tellamConversationViewModel.recentConversations,
                        builder: (context, snapshot) {
                          //loading  recent conversation
                          if ((!snapshot.hasData && !snapshot.hasError)) {
                            // return DataLoadingIndicator();
                            return SizedBox.shrink();
                          }
                          //failed to load data
                          else if (snapshot.hasError) {
                            final errorStateDataModel = StateDataModel();
                            errorStateDataModel.iconData = Icons.sms_failed;
                            errorStateDataModel.iconColor =
                                Tellam.uiConfiguration.primaryDarkColor;
                            errorStateDataModel.title = "Connection Problem";
                            errorStateDataModel.description =
                                "There was a connection problem getting requested data. Please try again later";
                            return PageStateView(
                              stateDataModel: errorStateDataModel,
                            );
                          }

                          return ListView(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Text(
                                "Recent conversations",
                                style: TellamTextStyles.h5TitleTextStyle(),
                              ),
                              //list of recent conversations
                              SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  final conversation = snapshot.data[index];
                                  final messages =
                                      snapshot.data[index].messages;
                                  //re-arrange the messages, to have the recent one on top
                                  messages.sort(
                                    (a, b) =>
                                        a.timestamp.compareTo(b.timestamp),
                                  );
                                  return ChatHeader(
                                    conversation: conversation,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 1,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),

                      //new conversation button
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        color: Tellam.uiConfiguration.buttonColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Tellam.uiConfiguration.buttonColor,
                          ),
                        ),
                        onPressed: () {
                          //start new conversation page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.send,
                        ),
                        label: Text("New Conversation"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                PoweredBy(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
