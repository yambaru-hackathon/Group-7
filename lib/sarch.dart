import 'package:flutter/material.dart';

//
// 画面 A
//
class Sarch extends StatelessWidget {
  const Sarch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: const Center(
        child: Text(
          'toukou',
          style: TextStyle(
            // 文字の大きさ
            fontSize: 20,
            // 文字の太さ
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
