import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/Providers/DevicesProvider.dart';
import 'package:firebasetest/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app-body/auth/login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DevicesProvider()),
      ],
      child: MaterialApp(
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}