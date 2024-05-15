import 'dart:math';

import 'package:flutter/material.dart';
import 'JoinScreen.dart';
// import 'screens/join_screen.dart';
// import 'services/signalling.service.dart';
import 'signallingService.dart';

void main() {
  // start videoCall app
  runApp(VideoCallApp());
}

class VideoCallApp extends StatelessWidget {
  VideoCallApp({super.key});

  // signalling server url
  final String websocketUrl2 = "http://10.0.2.2:8000"; //for emulator

  // "http://localhost:5000"; //for web
  final String websocketUrl = "http://localhost:8000";
  // "http://10.0.2.2:5000";

  final String websocketUrl3 = "http://10.5.121.22:8000";
  //  "http://localhost:5000";
  // //empty

  // generate callerID of local user
  final String selfCallerID =
      Random().nextInt(999999).toString().padLeft(6, '0');

  @override
  Widget build(BuildContext context) {
    // init signalling service
    SignallingService.instance.init(
      websocketUrl: websocketUrl,
      websocketUrl2: websocketUrl2,
      websocketUrl3: websocketUrl3,
      selfCallerID: selfCallerID,
    );

    // return material app
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      themeMode: ThemeMode.dark,
      home: JoinScreen(selfCallerId: selfCallerID),
    );
  }
}
