import 'package:flutter_gyuukaku/main.dart';
import 'package:flutter_gyuukaku/mypage.dart';
import 'package:flutter_gyuukaku/review.dart';
import 'package:flutter_gyuukaku/store_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//
// 画面 A
//
class Sarch extends StatelessWidget {
  const Sarch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ボタンが押された時の処理
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newpage()),
          );
        },
        backgroundColor: Color.fromARGB(170, 125, 196, 255),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16),
              child: Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      //押したときの動作
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => store()),
                      );
                    },
                    child: Text(
                      'Mr.Dount',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Text(
                    '¥1200',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 420,
              height: 310,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('images/IMG_7263.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  //押したときの動作
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mypage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 45,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            '_gyukaku_nago',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'nago okinawa',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 234, 234, 234),
                        elevation: 10,
                      ),
                      onPressed: () {
                        //押したときの動作
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Feedpage()),
                        );
                      },
                      child: Text(
                        'レビューを見る',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16),
              child: Row(
                children: [
                  Text(
                    'Mr.Dount',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Text(
                    '¥1200',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 420,
              height: 310,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('images/IMG_7265.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                    size: 45,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          '_gyukaku_nago',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'nago okinawa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: Text(
                      'レビューを見る',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 16),
              child: Row(
                children: [
                  Text(
                    'Mr.Dount',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Text(
                    '¥1200',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 420,
              height: 310,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('images/IMG_7264.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.grey,
                    size: 45,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          '_gyukaku_nago',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'nago okinawa',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: Text(
                      'レビューを見る',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class newpage extends StatelessWidget {
  const newpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.blue,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'レビューを投稿!',
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
                    width: 320,
                    //color: Colors.yellow,
                    child: Text(
                      '登録したユーザー名とレビューはサービス上で公開されます',
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
              SizedBox(height: 15),
              Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    '店名',
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
              SizedBox(height: 15),
              Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    '値段',
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
                    hintText: '例 : 500円',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    'レビュー',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(flex: 8),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 45, right: 45),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '例 : おいしかったまた行きたい',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '総合',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RatingBar.builder(
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        itemSize: 30,
                        onRatingUpdate: (rating) {
                          //評価が更新されたときの処理を書く
                        },
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '味',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              //評価が更新されたときの処理を書く
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '衛星',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              //評価が更新されたときの処理を書く
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '雰囲気',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              //評価が更新されたときの処理を書く
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  )
                ],
              ),
              SizedBox(height: 20),
              SliderWidget(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(flex: 1),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 74, 110, 255),
                      elevation: 10,
                    ),
                    onPressed: () {},
                    child: Text(
                      'レビューを投稿',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0.0; // スライダーの現在の値

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1人', // 最小値のラベル
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '複数', // 最大値のラベル
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 10), // スペースを追加
        Slider(
          value: _value,
          min: 0.0,
          max: 100.0,
          divisions: 10,
          onChanged: (double newValue) {
            setState(() {
              _value = newValue;
            });
          },
        ),
        SizedBox(height: 10), // スペースを追加
      ],
    );
  }
}
