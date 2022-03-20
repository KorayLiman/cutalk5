import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.chat}) : super(key: key);
  Chat chat;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            title: const Text("Sohbet"),
            backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(88, 117, 251, 1),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(280))),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
              child: Material(
                  borderRadius: BorderRadius.circular(4),
                  elevation: 10,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(widget.chat.OwnerProfileUrl),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.chat.OwnerName,
                                    maxLines: 2,
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.chat.OwnerEmail,
                                    maxLines: 2,
                                    style: GoogleFonts.ubuntu(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.chat.OwnerName + " diyor ki:",
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.grey.shade800,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: AutoSizeText(
                                        widget.chat.Content,
                                        style: GoogleFonts.ubuntu(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade800),
                                        minFontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                  widget.chat.PostedAt == null
                                      ? formatter.format(DateTime.now())
                                      : formatter.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              widget.chat.PostedAt!
                                                  .toDate()
                                                  .millisecondsSinceEpoch)),
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.grey.shade800),
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.comment,
                                        color: Colors.grey.shade800),
                                    Text(
                                      widget.chat.CommentCount.toString(),
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.grey.shade800),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Text(
                                "Yorumlar",
                                style: GoogleFonts.ubuntu(fontSize: 18),
                              )),
                            ],
                          ),
                        )),
                        Expanded(
                            flex: 5,
                            child: Container(
                              child: SingleChildScrollView(
                                  // child: FutureBuilder(
                                  //   builder: (context, snapshot) {},
                                  //    future: _GetCommentList(),
                                  // ),
                                  ),
                            ))
                      ],
                    ),
                  )),
            )
          ],
        ));
  }

  Future<Timestamp?> _GetPostedAtDate() async {
    return widget.chat.PostedAt;
  }

  // Future<List> _GetCommentList() async {
  //   final _chatmodel = Provider.of<ChatModel>(context, listen: false);
  //   return await _chatmodel.GetAllComments();
  // }
}
