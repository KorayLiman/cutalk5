import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key, required this.imgurl}) : super(key: key);
  final String imgurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 100.0, bottom: 100, left: 40, right: 40),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              imgurl,
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
