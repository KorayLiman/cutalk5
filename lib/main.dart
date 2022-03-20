import 'package:ctlk2/firebase_options.dart';
import 'package:ctlk2/locator.dart';
import 'package:ctlk2/pages/LandingPage.dart';
import 'package:ctlk2/viewmodels/chatmodel.dart';
import 'package:ctlk2/viewmodels/usermodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserModel();
          },
        ),
        ChangeNotifierProvider(create: (context) {
          
          return ChatModel();
        })
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cü Talk',
          home: LandingPage()),
    );
  }
}
