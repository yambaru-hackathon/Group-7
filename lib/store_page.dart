import 'package:flutter/material.dart';

  final img = [
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",    
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",
  ];

class Sarch extends StatelessWidget {
  const Sarch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container(
                  width: 393,
                  height: 110,
                  color: Colors.white,
                  // child: FittedBox(
                  //   fit: BoxFit.fitWidth,
                  //   child: Image.asset('images/Kapel.png'),
                  // ),
              ),
              SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  SizedBox(width: 15,),
                  Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF03FB93),
                  ),
                ),
                SizedBox(width: 3,),
                Text(
                  '営業中',
                    style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                )
              ],
            ),
                Center(
                  child: Text(
                    'Mr Donut',
                      style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      ),
                  ),
                ),
                SizedBox(height: 3,),
                Center(
                  child: Text(
                      '昔ながらの製法で作り続ける沖縄そばのお店',
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        ),
                    ),
                ),
                SizedBox(height: 30,),
            Row(
              children: [
                Spacer(flex: 1,),
                Text(
                  '☆4.7',
                    style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    ),
                ),
                Spacer(flex: 2,),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '味',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      children: [
                        Text(
                          '衛星',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      children: [
                        Text(
                          '雰囲気',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 2,),
                  Column(
                    children: [
                        Container(
                        width: 90,
                        height: 33,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: Text(
                            '213',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4992FF),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      'いいね！',
                      style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 17,),
                      Container(
                        width: 90,
                        height: 33,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: Text(
                            '9',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4992FF),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      '件の投稿',
                      style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 1,),
              ],
            ),
          SizedBox(height: 40,),
          Row(
            children: [
              Spacer(flex: 2,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(85,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () { /* ボタンがタップされた時の処理 */ },
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 14,
                    ),
                    Text(
                      'GO',
                        style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4992FF),
                        ),
                      ),
                  ],
                ),
                ),
              Spacer(flex: 3,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(105,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () { /* ボタンがタップされた時の処理 */ },
                child: Text(
                  '詳細情報',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4992FF),
                    ),
                  ),
                ),
              Spacer(flex: 3,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(85,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () { /* ボタンがタップされた時の処理 */ },
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 14,
                      color: const Color(0xFF4992FF),
                    ),
                    Text(
                      '電話',
                        style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4992FF),
                        ),
                      ),
                  ],
                ),
                ),
                Spacer(flex: 2,),
            ],
          ),

          SizedBox(height: 20,),

          // 画像まとめているところ
          Container(
            width: double.infinity,
            height: 6,
            color: const Color(0xFFD9D9D9),
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: img.map((img) {
                return InstagramPostItem(img: img);
              }).toList(),
            )
          )
          ]),
      ),
    );
  }
}


class InstagramPostItem extends StatelessWidget {
  const InstagramPostItem({Key? key,required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 画像が押された時の処理
      },
      child: Image.asset(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: Sarch(),
  ));
}