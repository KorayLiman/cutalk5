import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DiscussionPrivate extends StatefulWidget {
  const DiscussionPrivate({Key? key}) : super(key: key);

  @override
  State<DiscussionPrivate> createState() => _DiscussionPrivateState();
}

class _DiscussionPrivateState extends State<DiscussionPrivate> {
  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: _usermodel.user!.IsFromUniversity
          ? GradientFloatingActionButton.extended(
              onPressed: () {
                Chat ch = Chat(
                    OwnerName: _usermodel.user!.UserName!,
                    OwnerEmail: _usermodel.user!.Email,
                    Content: "qqweqweqewe",
                    OwnerId: _usermodel.user!.UserID,
                    ChatID: _usermodel.user!.UserName.toString() +
                        Uuid().v4().toString(),
                    OwnerProfileUrl: _usermodel.user!.ProfileURL!,
                    IsPrivate: true,
                    Comments: <String>["hello"]);
                _chatmodel.SaveChat(ch);
                setState(() {});
              },
              label: const Text("Sohbet oluştur"),
              icon: Icon(Icons.message),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(240, 43, 17, 1),
                Color.fromRGBO(244, 171, 25, 1)
              ]))
          : null,
      body: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        ),
      ),
    );
  }
}
