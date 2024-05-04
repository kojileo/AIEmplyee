import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchScreen extends StatefulWidget {
  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int currentImageIndex = 0; // 現在表示している画像のインデックス
  List<String> imagePaths = [
    'assets/images/web.png',
    'assets/images/youtube.png',
    'assets/images/pdf.png',
  ];

  // 各画像に対応するエンドポイントURL
  List<String> serviceEndpoints = [
    'https://api.example.com/web-service',
    'https://api.example.com/youtube-service',
    'https://api.example.com/pdf-service',
  ];

  void _nextImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
    });
  }

  void _goToChat() async {
    final url = serviceEndpoints[currentImageIndex];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('生成AIサービス選択'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.asset(imagePaths[currentImageIndex]),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('この生成AIサービスを選択しますか？', textAlign: TextAlign.center),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _goToChat,
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 233, 203),
                ),
              ),
              ElevatedButton(
                onPressed: _nextImage,
                child: Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
