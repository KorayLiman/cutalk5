import 'dart:io';

import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/pages/DetailsPage.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:ctlk2/widgets/PlatformSensitiveDeleteButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionGeneral extends StatefulWidget {
  DiscussionGeneral({Key? key}) : super(key: key);

  @override
  State<DiscussionGeneral> createState() => _DiscussionGeneralState();
}

class _DiscussionGeneralState extends State<DiscussionGeneral> {
  late bool isIos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isIos = Platform.isIOS ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ListTile(
                    title: TextFormField(
                      onFieldSubmitted: (value) {
                        if (value.length > 0) {
                          Chat ch = Chat(
                              Content: value,
                              ChatID: _usermodel.user!.UserName.toString() +
                                  Uuid().v4().toString(),
                              OwnerId: _usermodel.user!.UserID,
                              OwnerProfileUrl: _usermodel.user!.ProfileURL!,
                              OwnerName: _usermodel.user!.UserName!,
                              OwnerEmail: _usermodel.user!.Email,
                              IsPrivate: false);
                          _chatmodel.SaveChat(ch);
                          Navigator.pop(context);
                          ;
                        }
                      },
                      decoration:
                          InputDecoration(hintText: "Sohbet içeriğinizi yazın"),
                      autofocus: true,
                    ),
                  ),
                );
              },
            );
            setState(() {});
          },
          label: const Text("Sohbet oluştur"),
          icon: const Icon(Icons.message),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(240, 43, 17, 1),
            Color.fromRGBO(244, 171, 25, 1)
          ])),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
          child: FutureBuilder<List<Chat>>(
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: GradientCircularProgressIndicator(
                      valueGradient: LinearGradient(colors: [
                    Color.fromRGBO(240, 43, 17, 1),
                    Color.fromRGBO(244, 171, 25, 1)
                  ])),
                );
              } else {
                var allChats = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () {
                    return OnRefresh();
                  },
                  child: ListView.builder(padding: EdgeInsets.zero,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      var CurrentChat = allChats[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              isIos
                                  ? CupertinoPageRoute(
                                      builder: (context) => DetailsPage(chat: CurrentChat,),
                                    )
                                  : MaterialPageRoute(
                                      builder: (context) => DetailsPage(chat: CurrentChat,),
                                    ));
                        },
                        onLongPress: () {
                          if (CurrentChat.OwnerId == _usermodel.user!.UserID ||
                              _usermodel.user!.Email ==
                                  "2020123170@cumhuriyet.edu.tr") {
                            PlatformSensitiveDeleteButton(
                              title: "Sil",
                              chat: CurrentChat,
                              callback: (){setState(() {
                                
                              });},
                              content: "Sohbeti silmek istiyor musunuz?",
                              mainButtonText: "Evet",
                              secondaryButtonText: "Hayır",
                            ).show(context);
                          }
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(CurrentChat.OwnerProfileUrl),
                        ),
                        title: Text(
                          CurrentChat.OwnerName,
                          maxLines: 1,
                          style: GoogleFonts.ubuntu(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: CurrentChat.OwnerEmail ==
                                    "2020123170@cumhuriyet.edu.tr"
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          CurrentChat.Content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.ubuntu(
                              color: CurrentChat.OwnerEmail ==
                                      "2020123170@cumhuriyet.edu.tr"
                                  ? Colors.orange
                                  : Colors.black),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              const Icon(Icons.message),
                              Text(CurrentChat.CommentCount.toString())
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                );
              }
            },
            future: GetChats(),
          ),
        ),
      ),
    );
  }

  Future<List<Chat>> GetChats() async {
    final _chatmodel = Provider.of<ChatModel>(context, listen: false);
    return await _chatmodel.GetAllChats(false);
  }

  Future<void> OnRefresh() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
    _usermodel.signOut();
  }
}
