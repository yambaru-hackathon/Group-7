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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                child: Image.asset('images/IMG_7263.jpg'),
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
