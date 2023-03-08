import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

import '../../helpers/constants.dart';
import '../../models/user.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/language_aware_widgets.dart';
import 'message_bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController listViewScrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  DatabaseReference chatRef =
      FirebaseDatabase.instance.ref().child('chat_rooms');

  String? otherUserId;
  String? otherUserImage;
  String? otherUserName;
  String? otherUserRole;
  String? orderId;
  bool isLoading = false;
  String? chat_id;

  int? userId;
  bool isExist = false, init = false;

  @override
  void initState() {
    getPageData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        otherUserId = args["other_user_id"];
        otherUserRole = args["other_user_role"];
        otherUserName = args["other_user_name"];
        orderId = args["order_id"];
      });
      log("order_id: ${otherUserId} and $otherUserRole and ${orderId}");
    }
    if (otherUserId != null && otherUserRole != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        //
        String? userId = context.read<UserProvider>().currentUser?.id;
        log("MK: userId $userId");
        if (userId != null && orderId != null) {
          setState(() {
            chat_id = '$userId$orderId$otherUserId';
          });
        }
      });
    }

    super.didChangeDependencies();
  }

  scrollToLast({fast = false}) async {
    // try {
    //   // await Future.delayed(Duration(milliseconds: 300));
    //   if (listViewScrollController.hasClients) {
    //     if (listViewScrollController.position == null) return;
    //     if (!init) {
    //       await Future.delayed(Duration(milliseconds: 50));
    //       if (listViewScrollController.position != null)
    //         listViewScrollController
    //             .animateTo(listViewScrollController.position.maxScrollExtent,curve: Curves.easeOut,duration: Duration(milliseconds: 500),);
    //     }else{
    //     listViewScrollController.animateTo(
    //       listViewScrollController.position.maxScrollExtent,
    //       curve: Curves.easeOut,
    //       duration: Duration(milliseconds: 500),
    //     );
    //     init = true;
    //     }
    //   } else {
    //     await Future.delayed(Duration(milliseconds: 100));
    //     if (!init) scrollToLast();
    //   }
    // } catch (e) {}
  }

  User? currentUser;

  getPageData() async {
    currentUser = context.read<UserProvider>().currentUser;
  }

  @override
  void dispose() {
    listViewScrollController.dispose();
    super.dispose();
  }

  String date = "";

  @override
  Widget build(BuildContext context) {
    log("MK: chat_id: $chat_id");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ReflectByLanguage(
                          child: Image.asset(
                            "assets/icons/back_arrow_icon.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Text(
                        otherUserName ?? "Chat User",
                        style: TextStyle(
                            fontSize: 18,
                            color: mainColor,
                            fontWeight: FontWeight.w500),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: chat_id != null && chat_id != ''
                ? FirebaseAnimatedList(
                    controller: listViewScrollController,
                    reverse: true,
                    sort: (a, b) {
                      var x = a.value as Map;
                      var y = b.value as Map;
                      print("=====>" + x['timestamp'].toString());
                      int aDate = x['timestamp'];
                      int bDate = y['timestamp'];
                      return bDate.compareTo(aDate);
                      // return x['timestamp'].compareTo(y['timestamp']);
                    },
                    physics: BouncingScrollPhysics(),
                    // shrinkWrap: false,

                    query: chatRef
                        .child(chat_id!)
                        .child('chats')
                        .orderByChild("timestamp"),

                    itemBuilder: (context, snapshot, animation, index) {
                      Map snap = snapshot.value as Map;
                      // if (snap.isNotEmpty) if (init == false)
                      //   scrollToLast(fast: true);
                      var isOther =
                          snap['creater_id'] != currentUser!.id.toString();

                      String messageDate =
                          '${DateFormat('MMM d, yyyy').format(DateTime.fromMicrosecondsSinceEpoch(snap['timestamp']))}';
                      bool showDate = messageDate != date;

                      if (messageDate ==
                          DateFormat('MMM d, yyyy').format(DateTime.now())) {
                        showDate = date != "Today";
                        date = "Today";
                      } else
                        date = messageDate;

                      return SizeTransition(
                          sizeFactor: CurvedAnimation(
                              parent: animation, curve: Curves.easeOut),
                          child: MessageBubble(
                              message: snap['message'] ?? '',
                              userName: !isOther
                                  ? 'You'
                                  : '${otherUserName ?? "Ananymous"}',
                              isOther: isOther,
                              key: ValueKey(snap),
                              url: snap['image'] ?? '',
                              type: snap['type'] ?? '',
                              timestamp: snap['timestamp']));
                    },
                    defaultChild: Center(
                      child: Text(
                        'Send a message to start a chat!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      'Send a message to start a chat!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 20, top: 10, right: 7),
            height: 70,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Type your message here...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                isLoading
                    ? SizedBox(height: 30, width: 30, child: LoadingIndicator())
                    : FloatingActionButton(
                        onPressed: () async {
                          if (messageController.text.isEmpty) {
                            return;
                          }
                          if (chat_id == null) {
                            showToast("cannot find chat");
                            return;
                          }

                          String key = await chatRef
                              .child(chat_id!)
                              .child('chats')
                              .push()
                              .key!;
                          DatabaseReference ref = await chatRef
                              .child(chat_id!)
                              .child('chats')
                              .child(key);
                          var message = messageController.text;
                          ref.set({
                            "message": message,
                            "creater_id": currentUser!.id.toString(),
                            "timestamp": DateTime.now().microsecondsSinceEpoch,
                            'type': 'text',
                            'from': 'app',
                          }).then((value) {
                            log("MK: value: in then");
                            scrollToLast();
                          });

                          messageController.text = '';
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        backgroundColor: mainColor,
                        elevation: 0,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
