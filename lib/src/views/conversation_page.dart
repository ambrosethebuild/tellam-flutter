import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_stack/image_stack.dart';
import 'package:tellam/src/utils/app_text_styles.dart';
import 'package:tellam/src/widgets/chat_header.dart';
import 'package:tellam/src/widgets/oval_image.dart';
import 'package:tellam/src/widgets/conversation_appbar.dart';

class ConversationPage extends StatefulWidget {
  ConversationPage({Key key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  //Agents images
  List<String> agents = [];

  double agentHeaderRightPositioned = -45;

  @override
  void initState() {
    super.initState();

    agents.add(
        "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1470406852800-b97e5d92e2aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80");
    agents.add(
        "https://images.unsplash.com/photo-1473700216830-7e08d47f858e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80");
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
            child: SvgPicture.network(
              'https://storage.googleapis.com/tellam/Endless-Constellation.svg',
              semanticsLabel: 'tellam',
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: GradientColors.teal,
                    ),
                  ),
                  // child: Center(
                  //   child: CircularProgressIndicator(),
                  // ),
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
                Text(
                  "Hi Ambrose 👋",
                  style: TellamTextStyles.h1TitleTextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Company intro
                Text(
                  "How can we help you today?",
                  style: TellamTextStyles.h5TitleTextStyle(
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                //Conversation card

                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Text(
                          "Your conversations",
                          style: TellamTextStyles.h5TitleTextStyle(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Typically replies in a few hours",
                          style: TellamTextStyles.h6TitleTextStyle(),
                        ),

                        //company agents
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 60,
                          child: Stack(
                            children: agents.map(
                              (agentUrl) {
                                agentHeaderRightPositioned += 45;
                                return Positioned(
                                  right: agentHeaderRightPositioned,
                                  child: OvalImage(
                                    height: 60,
                                    weight: 60,
                                    url: agentUrl,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              OvalImage(
                                height: 60,
                                weight: 60,
                              ),
                              OvalImage(
                                height: 60,
                                weight: 60,
                              ),
                              OvalImage(
                                height: 60,
                                weight: 60,
                              ),
                              OvalImage(
                                height: 60,
                                weight: 60,
                              ),
                            ],
                          ),
                        ),

                        //recent conversations
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Recent conversations",
                          style: TellamTextStyles.h5TitleTextStyle(),
                        ),
                        //list of recent conversations
                        /*
                        ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ChatHeader(),
                            ChatHeader(),
                            ChatHeader(),
                          ],
                        ),
                        */

                        //new conversation button
                        RaisedButton.icon(
                          onPressed: () {
                            print("New conversation");
                          },
                          icon: Icon(
                            Icons.send,
                          ),
                          label: Text("New Conversation"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
