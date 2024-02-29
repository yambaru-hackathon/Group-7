import 'package:flutter/material.dart';

void main() {
  runApp(login());
}

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: welcom(),
    );
  }
}

class welcom extends StatelessWidget {
  const welcom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Spacer(flex: 1),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset('images/gyuu.jpg'),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            Text(
              'ギュウカクへようこそ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              '次世代のグルメ探しを楽しもう',
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 230,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.blue,
                      width: 3,
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => newlogin()),
                  );
                },
                child: Text(
                  '新規登録',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 230,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: Text(
                  'ログイン',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class newlogin extends StatelessWidget {
  const newlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.blue,
              iconSize: 40,
            ),
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'アカウントを新規作成',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  width: 310,
                  //color: Colors.yellow,
                  child: Text(
                    'プロフィールに登録したユーザー名と写真と名前はサービス上で公開されます。',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Spacer(flex: 1),
                Container(
                  padding: EdgeInsets.all(40),
                  height: 150,
                  width: 240,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 5),
                    borderRadius: BorderRadius.circular(20),
                    //color: Colors.yellow,
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 60,
                    color: const Color.fromARGB(217, 158, 158, 158),
                  ),
                ),
                Spacer(flex: 1)
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Spacer(flex: 1),
                Text(
                  'ユーザー名',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '例 : ギュウカク',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(flex: 1),
                Text(
                  'パスワード',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '英数字大文字小文字6文字以上',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Spacer(flex: 1),
                Text(
                  '好きなもの',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(flex: 8),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //hintText: '例 : ギュウカク',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Spacer(flex: 1),
                SizedBox(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: Text(
                      '新規登録',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
