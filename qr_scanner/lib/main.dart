import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/Pages/QR%20Generator.dart';
import 'package:qr_scanner/Pages/QR%20Scanner.dart';
import 'package:qr_scanner/firebase_options.dart';

Future<void> main() async {
// final gsheets = Gsheets(_credintial);
 WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code generator',
      home: QrGenerator(),
    );
  }
}
