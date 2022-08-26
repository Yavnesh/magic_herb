import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:magic_herb/auth/auth_services.dart';
import 'package:magic_herb/auth/wrapper.dart';
import 'package:provider/provider.dart';

StreamController<int> streamController = StreamController<int>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        Provider<AuthService>(
        create: (_) => AuthService(),
    ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic Herb',
      home: Wrapper(),
    ),
    );
  }
}

