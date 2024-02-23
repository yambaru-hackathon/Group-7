import 'package:flutter/material.dart';

  final img = [
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",    
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",
  ];
// このコードでは、Stackウィジェットを使用して、ブックマークリストボタンが押されたときにオーバーレイを表示しています。オーバーレイは_isOverlayVisible変数によって制御され、_toggleOverlayメソッドを使用して状態を切り替えます。
class Mypage extends StatefulWidget {
  Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  bool _isOverlayVisible = false;

  void _toggleOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Kapsel.png'),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ユーザーネーム',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            Text(
                              '#肉好き',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4992FF),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(
                              '#ダイエットは明日から',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
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
                      ],
                    ),
                    Spacer(flex: 1,),
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
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15,),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(260,33),
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: _toggleOverlay,
                      child: Text(
                        'ブックマークリスト',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4992FF),
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(80,33),
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Center(
                        child: Icon(
                          Icons.ios_share,
                          color: const Color(0xFF4992FF),
                        ),
                      )
                    ),
                    SizedBox(width: 15,),
                  ],
                ),
                SizedBox(height: 20,),
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
              ],
            ),
          ),
          if (_isOverlayVisible)
            GestureDetector(
              onTap: _toggleOverlay,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 630,
                    decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(
                          color: Colors.black,
                          width: 4),
                        ),
                    child: 
                    Column(
                      children: [
                        SizedBox(height: 30,),
                        Container(
                          width: 240,
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4992FF),
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Center(
                            child: Text(
                              'ブックマークリスト',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: img.map((img) {
                        return InstagramPostItem(img: img);
                          }).toList(),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
        ],
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
