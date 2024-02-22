import 'package:flutter/material.dart';

//
//画面B
//
class Map extends StatelessWidget {
  const Map({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20), // 余白を追加
            Text(
              '画面 B',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // 余白を追加
            Row(
              children: [
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(40),
                  height: 50,
                  width: 310,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '例 : ギュウカク',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
