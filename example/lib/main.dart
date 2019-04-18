import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_shake_plugin/flutter_shake_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterShakePlugin _shakePlugin;

  @override
  void initState() {
    super.initState();
    _shakePlugin = FlutterShakePlugin(
      onPhoneShaken: (){
        //do stuff on phone shake
        print('phone shakes');
      },
    )..startListening();
  }

  @override
  void dispose() {
    super.dispose();
    _shakePlugin.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shake Plugin example app'),
        ),
      ),
    );
  }
}
