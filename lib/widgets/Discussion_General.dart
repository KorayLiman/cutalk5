import 'package:flutter/material.dart';

class DiscussionGeneral extends StatefulWidget {
  DiscussionGeneral({Key? key}) : super(key: key);

  @override
  State<DiscussionGeneral> createState() => _DiscussionGeneralState();
}

class _DiscussionGeneralState extends State<DiscussionGeneral> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 140.0),
      child: Container(
        height: MediaQuery.of(context).size.height - 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            
      ),
    );
  }
}
