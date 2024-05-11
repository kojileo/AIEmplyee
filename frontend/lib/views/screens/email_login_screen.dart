import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/views/screens/match_screen.dart'; // MatchScreenのインポート

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    try {
      // Firebase Authenticationを使用してログイン
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), // メールアドレスの前後の空白を削除
        password: _passwordController.text.trim(), // パスワードの前後の空白を削除
      );
      // ログイン成功時にMatchScreenに遷移
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MatchScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // ログイン失敗時のエラーハンドリング
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'このメールアドレスは登録されていません。';
          break;
        case 'wrong-password':
          errorMessage = 'パスワードが間違っています。';
          break;
        default:
          errorMessage = 'ログインに失敗しました。エラーコード: ${e.code}';
          break;
      }
      setState(() {
        _errorMessage = errorMessage;
      });
    } catch (e) {
      // その他のエラー
      setState(() {
        _errorMessage = '予期せぬエラーが発生しました。';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'パスワード',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('ログイン'),
            ),
            SizedBox(height: 20),
            Text(_errorMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
