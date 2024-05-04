import 'package:flutter/material.dart';
import '/views/screens/match_screen.dart'; // このパスは、実際のプロジェクト構造に合わせて調整してください

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 画面のサイズを取得
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('生成AI基盤アプリ'),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ai_title.png',
                    width: screenWidth, // 画面幅の1/2のサイズで画像を表示
                    // heightも必要に応じて設定することができます
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchScreen()));
                    },
                    child: Text('スタート'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // ここを修正
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
