import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebaseのインポート
import 'views/screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutterバインディングの初期化
  await dotenv.load(fileName: ".env");

  // Firebaseの設定を.envから読み込み
  final firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!, // APIキー
    appId: dotenv.env['FIREBASE_APP_ID']!, // アプリID
    messagingSenderId:
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!, // メッセージングセンダーID
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!, // プロジェクトID
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'], // Auth Domain
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'], // Storage Bucket
    measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID'], // Measurement ID
  );

  // Firebaseの初期化に設定を渡す
  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // keyを追加して、constコンストラクタを使います。
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Matching App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: Size(360, 640), // ここでスマホの画面サイズを指定します。
          ),
          child: widget!,
        );
      },
    );
  }
}
