import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return FutureBuilder<List<String>>(
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
    );
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
