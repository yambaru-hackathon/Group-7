import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final db = FirebaseFirestore.instance;

class UserWidget extends StatelessWidget {
  final String postID;

  const UserWidget({Key? key, required this.postID}) : super(key: key);

  Future<String?> getStoreNameFromPostID(String postID) async {
    try {
      DocumentSnapshot postSnapshot = await db.collection('posts').doc(postID).get();
      String storeID = postSnapshot.get('storeid');
      DocumentSnapshot storeSnapshot = await db.collection('stores').doc(storeID).get();
      String storeName = storeSnapshot.get('name');
      return storeName;
    } catch (e) {
      print('Error fetching store name: $e');
      return null;
    }
  }

  Future<String?> getUserNameFromPostID(String postID) async {
    try {
      DocumentSnapshot postSnapshot = await db.collection('posts').doc(postID).get();
      String userID = postSnapshot.get('userid');
      DocumentSnapshot userSnapshot = await db.collection('users').doc(userID).get();
      String userName = userSnapshot.get('name');
      return userName;
    } catch (e) {
      print('Error fetching user name: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: db.collection('posts').doc(postID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('エラー：${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final userMap = snapshot.data?.data() as Map<String, dynamic>?;

        if (userMap == null) {
          return Text('ユーザーデータが見つかりませんでした。');
        }

        return FutureBuilder<String?>(
          future: getStoreNameFromPostID(postID),
          builder: (context, storeNameSnapshot) {
            if (storeNameSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (storeNameSnapshot.hasError) {
              return Text('エラー：${storeNameSnapshot.error}');
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 50,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right:16, left: 16),
                    child: Row(
                      children: [
                        Text(
                          storeNameSnapshot.data ?? '', // 店舗名を表示
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        for (int i = 0; i < 5; i++) // 5つの星を表示する
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.blue,
                          ),
                        Spacer(),
                        Text(
                          '¥${userMap['discount']}',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                        ),
                        Icon(
                          Icons.bookmark_border,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Image.network(
                        userMap['image'],
                      ),
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            // ボタンが押されたときの処理
                          },
                          child: Text(
                            'GO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        FutureBuilder<String?>(
                          future: getUserNameFromPostID(postID),
                          builder: (context, userNameSnapshot) {
                            if (userNameSnapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (userNameSnapshot.hasError) {
                              return Text('エラー：${userNameSnapshot.error}');
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userNameSnapshot.data ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Spacer(),
                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 1,
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
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class PostWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ボタンが押された時の処理
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newpage()),
          );
        },
        backgroundColor: Color.fromARGB(170, 125, 196, 255),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchPostIDs(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('エラー：${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return UserWidget(postID: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}


  Future<List<String>> fetchPostIDs() async {
    List<String> postIDs = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('posts').get();

      querySnapshot.docs.forEach((doc) {
        postIDs.add(doc.id);
      });
    } catch (e) {
      print("Error fetching post IDs: $e");
    }

    return postIDs;
  }

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized(); // Flutter のバインディングが初期化されていることを確認します。
//   await Firebase.initializeApp(); // Firebase を初期化します。
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: PostWidgets(),
//     ),
//   ));
// }


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