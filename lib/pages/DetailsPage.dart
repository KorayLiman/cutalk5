import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctlk2/SwearBlocker.dart';
import 'package:ctlk2/models/Block.dart';
import 'package:ctlk2/models/Chat.dart';
import 'package:ctlk2/models/Comment.dart';
import 'package:ctlk2/models/Reports.dart';
import 'package:ctlk2/models/user.dart';
import 'package:ctlk2/pages/FullScreenImage.dart';

import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:ctlk2/widgets/PlatformSensitiveAlertDialog.dart';
import 'package:ctlk2/widgets/PlatformSensitiveDeleteButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:uuid/uuid.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.chat}) : super(key: key);
  Chat chat;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final ImagePicker _picker = ImagePicker();
  late bool isLiked;

  List<File> Imgs = [];
  String? Subject;
  final TextEditingController _textEditingController = TextEditingController();
  String? CommentString;
  @override
  Widget build(BuildContext context) {
    final _chatmodel = Provider.of<ChatModel>(context);
    final _usermodel = Provider.of<UserModel>(context);
    isLiked = (widget.chat.Likes![_usermodel.user!.UserID] == true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                              width: 10,
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
                            ),
                            Expanded(
                              child: PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text(
                                        "Rapor et",
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.red),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container();
                                            });
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0,
                                                    right: 30,
                                                    top: 50,
                                                    bottom: 300),
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Rapor et",
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 21),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: TextFormField(
                                                            autofocus: true,
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            validator: (value) {
                                                              if (value!
                                                                      .length <
                                                                  1) {
                                                                return "Konu 1 harften b??y??k olmal??";
                                                              }
                                                            },
                                                            onChanged: (value) {
                                                              Subject = value;
                                                            },
                                                            maxLines: 3,
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    "Konu",
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                filled: true,
                                                                border: OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none)),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                              if (Subject !=
                                                                  null) {
                                                                Report
                                                                    NewReport =
                                                                    Report(
                                                                  Subject:
                                                                      Subject!,
                                                                  ReportedChatID:
                                                                      widget
                                                                          .chat
                                                                          .ChatID,
                                                                );
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "reports")
                                                                    .add(NewReport
                                                                        .ToMap());
                                                                Subject = null;
                                                                PlatformSensitiveAlertDialog(
                                                                  title:
                                                                      "Ba??ar??l??",
                                                                  content:
                                                                      "Rapor incelenmek ??zere g??nderildi",
                                                                  mainButtonText:
                                                                      "Tamam",
                                                                ).show(context);
                                                              }
                                                            },
                                                            child: const Text(
                                                                "G??nder"))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text("Blokla",
                                          style: GoogleFonts.ubuntu(
                                              color: Colors.orange)),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container();
                                            });
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return PlatformSensitiveDeleteButton(
                                                title: "Blokla",
                                                callback: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return PlatformSensitiveDeleteButton(
                                                          title: "Emin misiniz",
                                                          callback: () async {
                                                            Block block = Block(
                                                                ReportedUserID:
                                                                    widget.chat
                                                                        .OwnerId,
                                                                ReportedChatID:
                                                                    widget.chat
                                                                        .ChatID,
                                                                ReportingUserID:
                                                                    _usermodel
                                                                        .user!
                                                                        .UserID);
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "blocks")
                                                                .add(block
                                                                    .ToMap());
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "users")
                                                                .doc(widget.chat
                                                                    .OwnerId)
                                                                .set(
                                                                    {
                                                                  "IsBlocked":
                                                                      true
                                                                },
                                                                    SetOptions(
                                                                        merge:
                                                                            true));
                                                                            
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                            await PlatformSensitiveAlertDialog(
                                                                    title:
                                                                        "Ba??ar??l??",
                                                                    content:
                                                                        "Kullan??c?? ba??ar??yla blokland??",
                                                                    mainButtonText:
                                                                        "Tamam")
                                                                .show(context);
                                                          },
                                                          content:
                                                              "Ger??ekten bloklamak istiyor musunuz? ",
                                                          mainButtonText:
                                                              "Evet",
                                                          secondaryButtonText:
                                                              "Hay??r",
                                                          mainButtonColor:
                                                              Colors.red,
                                                        );
                                                      });
                                                },
                                                content:
                                                    "Dikkat!!! Sadece gerekli durumlarda bloklay??n??z. K??t??ye kullan??mda(Gereksiz bloklama vb) bloklayan kullan??c?? engellenir ",
                                                mainButtonText: "Blokla",
                                                secondaryButtonText: "Vazge??",
                                                mainButtonColor: Colors.red,
                                              );
                                            });
                                      },
                                    ),
                                  ];
                                },
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
                          flex: 3,
                          child: Container(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.chat.ImageCount,
                                itemExtent: 170,
                                itemBuilder: (context, index) {
                                  return FutureBuilder<List<String>>(
                                    future: _GetImagesList(widget.chat.ChatID),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                Platform.isIOS
                                                    ? CupertinoPageRoute(
                                                        builder: (context) =>
                                                            FullScreenImage(
                                                                imgurl: snapshot
                                                                    .data![
                                                                        index]
                                                                    .toString()),
                                                      )
                                                    : MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullScreenImage(
                                                          imgurl: snapshot
                                                              .data![index]
                                                              .toString(),
                                                        ),
                                                      ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: snapshot.data!.length <
                                                    widget.chat.ImageCount!
                                                        .toInt()
                                                ? Image.file(Imgs[index])
                                                : Image.network(
                                                    snapshot.data![index]
                                                        .toString(),
                                                  ),
                                          ),
                                        );
                                      } else {
                                        return const Text("");
                                      }
                                    },
                                  );
                                }),
                          )),
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
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        HandleLikePosts();
                                      },
                                      icon: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.pink,
                                      )),
                                  Text(widget.chat.LikeCount.toString(),
                                      style: GoogleFonts.ubuntu(
                                        color: Colors.grey.shade800,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.comment,
                                      color: Colors.grey.shade800),
                                  Text(
                                    widget.chat.CommentCount.toString(),
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.grey.shade800),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
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
                                child: FutureBuilder<List<Comment>>(
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 80.0),
                                              child: LinearProgressIndicator(
                                                color: Color.fromRGBO(
                                                    131, 0, 254, 1),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 80.0),
                                              child: LinearProgressIndicator(
                                                color: Color.fromRGBO(
                                                    219, 0, 254, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var currentComment =
                                              snapshot.data![index];
                                          return ListTile(
                                              trailing: PopupMenuButton(
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      child: Text(
                                                        "Rapor et",
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container();
                                                            });
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            30.0,
                                                                        right:
                                                                            30,
                                                                        top: 50,
                                                                        bottom:
                                                                            300),
                                                                child: Material(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16)),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "Rapor et",
                                                                          style: GoogleFonts.ubuntu(
                                                                              color: Colors.black,
                                                                              fontSize: 21),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              TextFormField(
                                                                            autofocus:
                                                                                true,
                                                                            autovalidateMode:
                                                                                AutovalidateMode.onUserInteraction,
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.length < 1) {
                                                                                return "Konu 1 harften b??y??k olmal??";
                                                                              }
                                                                            },
                                                                            onChanged:
                                                                                (value) {
                                                                              Subject = value;
                                                                            },
                                                                            maxLines:
                                                                                3,
                                                                            decoration: InputDecoration(
                                                                                hintText: "Konu",
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                border: OutlineInputBorder(borderSide: BorderSide.none)),
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              Navigator.pop(context);
                                                                              if (Subject != null) {
                                                                                Report NewReport = Report(Subject: Subject!, ReportedCommentID: currentComment.CommentID, ReportedCommentContent: currentComment.Content);
                                                                                FirebaseFirestore.instance.collection("reports").add(NewReport.ToMap());
                                                                                Subject = null;
                                                                                PlatformSensitiveAlertDialog(
                                                                                  title: "Ba??ar??l??",
                                                                                  content: "Rapor incelenmek ??zere g??nderildi",
                                                                                  mainButtonText: "Tamam",
                                                                                ).show(context);
                                                                              }
                                                                            },
                                                                            child:
                                                                                const Text("G??nder"))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      child: Text("Blokla",
                                                          style: GoogleFonts
                                                              .ubuntu(
                                                                  color: Colors
                                                                      .orange)),
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container();
                                                            });
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return PlatformSensitiveDeleteButton(
                                                                title: "Blokla",
                                                                callback:
                                                                    () async {
                                                                  await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return PlatformSensitiveDeleteButton(
                                                                          title:
                                                                              "Emin misiniz",
                                                                          callback:
                                                                              () async {
                                                                            Block
                                                                                block =
                                                                                Block(ReportedUserID: currentComment.OwnerID, ReportedCommentContent: currentComment.Content, ReportingUserID: _usermodel.user!.UserID);
                                                                            await FirebaseFirestore.instance.collection("blocks").add(block.ToMap());
                                                                            await FirebaseFirestore.instance.collection("users").doc(widget.chat.OwnerId).set({
                                                                              "IsBlocked": true
                                                                            }, SetOptions(merge: true));
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            await PlatformSensitiveAlertDialog(title: "Ba??ar??l??", content: "Kullan??c?? ba??ar??yla blokland??", mainButtonText: "Tamam").show(context);
                                                                          },
                                                                          content:
                                                                              "Ger??ekten bloklamak istiyor musunuz? ",
                                                                          mainButtonText:
                                                                              "Evet",
                                                                          secondaryButtonText:
                                                                              "Hay??r",
                                                                          mainButtonColor:
                                                                              Colors.red,
                                                                        );
                                                                      });
                                                                },
                                                                content:
                                                                    "Dikkat!!! Sadece gerekli durumlarda bloklay??n??z. K??t??ye kullan??mda(Gereksiz bloklama vb) bloklayan kullan??c?? engellenir ",
                                                                mainButtonText:
                                                                    "Blokla",
                                                                secondaryButtonText:
                                                                    "Vazge??",
                                                                mainButtonColor:
                                                                    Colors.red,
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  ];
                                                },
                                              ),
                                              onLongPress: () {
                                                if (currentComment.OwnerID ==
                                                        _usermodel
                                                            .user!.UserID ||
                                                    _usermodel.user!.Email ==
                                                        "2020123170@cumhuriyet.edu.tr") {
                                                  PlatformSensitiveDeleteButton(
                                                    title: "Sil",
                                                    content:
                                                        "Yorumu silmek istedi??inizden emin misiniz?",
                                                    mainButtonText: "Evet",
                                                    secondaryButtonText:
                                                        "Hay??r",
                                                    callback: () async {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "comments")
                                                          .doc(currentComment
                                                              .CommentID)
                                                          .delete()
                                                          .then((value) {
                                                        widget.chat
                                                            .CommentCount = widget
                                                                .chat
                                                                .CommentCount! -
                                                            1;
                                                        setState(() {});
                                                      });
                                                    },
                                                  ).show(context);
                                                } else {
                                                  SnackBar snackBar = SnackBar(
                                                      content: Text(
                                                          currentComment
                                                              .OwnerEmail));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                }
                                              },
                                              subtitle:
                                                  FutureBuilder<CuTalkUser>(
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      currentComment.Content,
                                                      style:
                                                          GoogleFonts.ubuntu(),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                },
                                                future: _GetCommentOwner(
                                                    currentComment.OwnerID),
                                              ),
                                              title: FutureBuilder<CuTalkUser>(
                                                future: _GetCommentOwner(
                                                    currentComment.OwnerID),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data!.UserName
                                                          .toString(),
                                                      style: GoogleFonts.ubuntu(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  } else {
                                                    return Text("");
                                                  }
                                                },
                                              ),
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    widget
                                                        .chat.OwnerProfileUrl),
                                              ));
                                        },
                                      );
                                    }
                                  },
                                  future: _GetCommentList(),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.fromBorderSide(BorderSide(color: Colors.grey))),
                height: 80,
                child: _usermodel.user!.UserID == widget.chat.OwnerId
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await _UploadPhotos(widget.chat);
                                setState(() {});
                              },
                              icon: Icon(Icons.photo)),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0,
                                  right: 8,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: TextFormField(
                                controller: _textEditingController,
                                onChanged: (Value) {
                                  CommentString = Value;
                                },
                                decoration: InputDecoration(
                                    hintText: "Yorum yap",
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              color: const Color.fromRGBO(88, 117, 251, 1),
                              onPressed: () {
                                if (_usermodel.user!.IsBlocked == false) {
                                  _UploadComment();
                                } else {
                                  PlatformSensitiveAlertDialog(
                                    title: "Blokland??n??z",
                                    content:
                                        "Bir Kullan??c?? taraf??ndan k??t??ye kullan??m sebebiyle blokland??n??z. Gereksiz yere blokland??????n??z?? d??????n??yorsan??z uygulama i??erisindeki Hata ve g??r???? bildir k??sm??ndan ula??abilirsiniz",
                                    mainButtonText: "Tamam",
                                  ).show(context);
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                size: 36,
                              ),
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 24.0, right: 8),
                              child: TextFormField(
                                controller: _textEditingController,
                                onChanged: (Value) {
                                  CommentString = Value;
                                },
                                onFieldSubmitted: (value) async {
                                  if (FirebaseAuth
                                      .instance.currentUser!.emailVerified) {
                                    _textEditingController.clear();
                                    var doc = await FirebaseFirestore.instance
                                        .collection("chats")
                                        .doc(widget.chat.ChatID)
                                        .set({
                                      "CommentCount": FieldValue.increment(1)
                                    }, SetOptions(merge: true));
                                    
                                    await _UploadComment();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    CommentString = null;
                                    setState(() {});
                                  } else {
                                    PlatformSensitiveAlertDialog(
                                      title: "Mail Onay??",
                                      content:
                                          "L??tfen yorum yazmak i??in mailinize gelen onay linkine t??klay??n. Daha sonra ????k???? yap??p tekrar giriniz. D??KKAT EMAIL ONAYI SPAM KUTUSUNA G??DEB??L??R L??TFEN SPAM KUTUSUNU KONTROL ED??N??Z.",
                                      mainButtonText: "Tamam",
                                    ).show(context);
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Yorum yap",
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                              color: const Color.fromRGBO(88, 117, 251, 1),
                              onPressed: () async {
                                if (FirebaseAuth
                                    .instance.currentUser!.emailVerified) {
                                  _textEditingController.clear();
                                  var doc = await FirebaseFirestore.instance
                                      .collection("chats")
                                      .doc(widget.chat.ChatID)
                                      .set({
                                    "CommentCount": FieldValue.increment(1)
                                  }, SetOptions(merge: true));
                                  await _UploadComment();
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  CommentString = null;
                                  setState(() {});
                                } else {
                                  PlatformSensitiveAlertDialog(
                                    title: "Mail Onay??",
                                    content:
                                        "L??tfen yorum yazmak i??in mailinize gelen onay linkine t??klay??n. Daha sonra ????k???? yap??p tekrar giriniz. D??KKAT EMAIL ONAYI SPAM KUTUSUNA G??DEB??L??R L??TFEN SPAM KUTUSUNU KONTROL ED??N??Z.",
                                    mainButtonText: "Tamam",
                                  ).show(context);
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                size: 36,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              bottom: 1,
              left: 0,
              right: 0,
            )
          ],
        ));
  }

  Future<Timestamp?> _GetPostedAtDate() async {
    return widget.chat.PostedAt;
  }

  Future<List<Comment>> _GetCommentList() async {
    final _chatmodel = Provider.of<ChatModel>(context, listen: false);
    return await _chatmodel.GetAllComments(widget.chat.ChatID);
  }

  Future<void> _UploadComment() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);

    if (CommentString != null && CommentString!.length > 0) {
      bool ContainsSwear = false;
      SwearBlockerClass.SwearBlocker.forEach((element) {
        if (element.length > 3) {
          if (CommentString!.toLowerCase().contains(element)) {
            ContainsSwear = true;
          }
        }
      });
      if (ContainsSwear == false) {
        try {
          var doc = await FirebaseFirestore.instance
              .collection("chats")
              .doc(widget.chat.ChatID)
              .set({"CommentCount": FieldValue.increment(1)},
                  SetOptions(merge: true));

          Comment com = Comment(
            OwnerEmail: _usermodel.user!.Email,
            BelongingChatID: widget.chat.ChatID,
            Content: CommentString!,
            CommentID: Uuid().v4(),
            OwnerID: _usermodel.user!.UserID,
          );
          await FirebaseFirestore.instance
              .collection("comments")
              .doc(com.CommentID)
              .set(com.toMap());
          FocusManager.instance.primaryFocus?.unfocus();
          _textEditingController.clear();
          setState(() {});
        } catch (error) {
          print(error.toString());
        }
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        _textEditingController.clear();
        setState(() {});
        PlatformSensitiveAlertDialog(
          title: "K??f??rl?? i??erik",
          content: "K??f??r veya hakaret yasakt??r",
          mainButtonText: "Anlad??m",
        ).show(context);
      }
    }
  }

  Future<CuTalkUser> _GetCommentOwner(String OwnerID) async {
    var doc = await FirebaseFirestore.instance.collection("users");
    var result = await doc.where("UserID", isEqualTo: OwnerID).get();
    CuTalkUser? user;
    for (var m in result.docs) {
      user = CuTalkUser.FromMap(m.data() as Map<String, dynamic>);
    }
    return user!;
  }

  Future<List<String>> _GetImagesList(String ChatID) async {
    var doc =
        await FirebaseFirestore.instance.collection("chats").doc(ChatID).get();
    List<String> imagelist = [];
    List<String> queryList =
        List<String>.from(doc["ChatImageContent"].cast<String>());
    if (queryList.length == 0) {
      return imagelist;
    } else {
      for (String s in queryList) {
        imagelist.add(s);
      }
    }
    return imagelist;
  }

  Future<void> _UploadPhotos(Chat chat) async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var i in images) {
        chat.ImageCount = chat.ImageCount! + 1;
        File f = File(i.path);
        Imgs.add(f);
        setState(() {});
      }
      for (var img in images) {
        File i = File(img.path);
        Imgs.add(i);
        await _usermodel.uploadChatFile(
            _usermodel.user!.UserID, "chatimage", i, widget.chat.ChatID);
      }
    }
  }

  void HandleLikePosts() async {
    final _usermodel = Provider.of<UserModel>(context, listen: false);

    String currentUserId = _usermodel.user!.UserID;
    // DocumentSnapshot doc = await FirebaseFirestore.instance
    //     .collection("chats")
    //     .doc(widget.chat.ChatID)
    //     .get();
    // Map LikesMap = doc["Likes"] as Map<String, dynamic>;
    bool _IsLiked = (widget.chat.Likes![currentUserId] == true);
    if (_IsLiked) {
      widget.chat.Likes![currentUserId] = false;
      isLiked = false;
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(widget.chat.ChatID)
          .update({"Likes.$currentUserId": false});
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(widget.chat.ChatID)
          .set(
              {"LikeCount": FieldValue.increment(-1)}, SetOptions(merge: true));
      widget.chat.LikeCount = widget.chat.LikeCount! - 1;
      setState(() {});
    } else {
      widget.chat.Likes![currentUserId] = true;
      isLiked = true;
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(widget.chat.ChatID)
          .update({"Likes.$currentUserId": true});
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(widget.chat.ChatID)
          .set({"LikeCount": FieldValue.increment(1)}, SetOptions(merge: true));
      widget.chat.LikeCount = widget.chat.LikeCount! + 1;
      setState(() {});
    }
  }
}
