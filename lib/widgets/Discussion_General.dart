import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:ctlk2/widgets/PlatformSensitiveDeleteButton.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionGeneral extends StatefulWidget {
  DiscussionGeneral({Key? key}) : super(key: key);

  @override
  State<DiscussionGeneral> createState() => _DiscussionGeneralState();
}

class _DiscussionGeneralState extends State<DiscussionGeneral> {
  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton.extended(
          onPressed: () {
            Chat ch = Chat(
                OwnerName: _usermodel.user!.UserName!,
                OwnerEmail: _usermodel.user!.Email,
                Content: "qqweqweqewe",
                OwnerId: _usermodel.user!.UserID,
                ChatID: _usermodel.user!.UserName.toString() +
                    Uuid().v4().toString(),
                OwnerProfileUrl: _usermodel.user!.ProfileURL!,
                IsPrivate: false,
                Comments: <String>["hello"]);
            _chatmodel.SaveChat(ch);
            setState(() {});
          },
          label: const Text("Sohbet oluştur"),
          icon: Icon(Icons.message),
          gradient: LinearGradient(colors: [
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
                return Center(
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
                  child: ListView.builder(
                    itemExtent: 70,
                    itemBuilder: (context, index) {
                      var CurrentChat = allChats[index];
                      return ListTile(
                          onLongPress: () {
                            if (CurrentChat.OwnerId ==
                                _usermodel.user!.UserID) {
                              PlatformSensitiveDeleteButton(
                                title: "Sil",
                                content: "Sohbeti silmek istiyor musunuz?",
                                mainButtonText: "Evet",
                                secondaryButtonText: "Hayır",
                              ).show(context);
                            }
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.tealAccent,
                            backgroundImage:
                                NetworkImage(CurrentChat.OwnerProfileUrl),
                          ),
                          title: Text(
                            CurrentChat.OwnerName,
                            maxLines: 1,
                            style: TextStyle(
                                color: CurrentChat.OwnerEmail ==
                                        "2020123170@cumhuriyet.edu.tr"
                                    ? Colors.orange
                                    : Colors.black),
                          ),
                          subtitle: Text(
                            CurrentChat.Content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: CurrentChat.OwnerEmail ==
                                        "2020123170@cumhuriyet.edu.tr"
                                    ? Colors.orange
                                    : Colors.black),
                          ));
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
