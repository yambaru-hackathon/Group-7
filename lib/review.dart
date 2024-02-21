import 'package:flutter/material.dart';


main() {
  // アップバー
  final appBar = AppBar(
    centerTitle: true,
    title: const Text('レビュー',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      )),
    backgroundColor: Colors.white,
  );

  // ボディ
  const body = Text('Mr.Donut',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 45,
    )  );
  // 画面
  final scaffold = Scaffold(
    backgroundColor: Colors.white,
    appBar: appBar, // アップバー
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                body,
              ],
            ),
          ),

          Container (
            padding: const EdgeInsets.all(100.0),
            child: ToggleButtons(isSelected: [false,false],
            color: Colors.green,
            fillColor: Color.fromARGB(255, 253, 193, 119),
            children: <Widget>[
              Padding(padding: EdgeInsets.all(40.0),
                child: Text('レビュー'),
              ),
              Padding(padding: EdgeInsets.all(40.0),
                child:Text('写真'),
              )
            ],
            ),
            ),
        ],
      ),
    ),
  );

  // アプリ
  final app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: scaffold,
  );
  runApp(app);
}