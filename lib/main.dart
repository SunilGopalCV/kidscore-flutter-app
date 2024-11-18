import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidscore/features/auth/presentation/pages/login_page.dart';
import 'package:kidscore/firebase_options.dart';
import 'package:kidscore/themes/light_mode.dart';

void main() async {
  //initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const LoginPage(),
    );
  }
}
