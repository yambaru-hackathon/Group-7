import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String? storeId; // Nullableに変更
  String price = '';
  String review = '';
  double overallRating = 0.0;
  double tasteRating = 0.0;
  double hygieneRating = 0.0;
  double atmosphereRating = 0.0;
  File? _image;

  // 画像を選択するメソッド
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // 画像を表示するウィジェット
  Widget _buildImagePreview() {
    return _image != null
        ? Image.file(
            _image!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        : InkWell(
            onTap: _getImage,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey[400],
              ),
            ),
          );
  }

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
              Center(
                child: Container(
                  width: 320,
                  child: Column(
                    children: [
                      _buildImagePreview(), // 画像プレビューウィジェットを追加
                      SizedBox(height: 20),
                      FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance.collection('stores').get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasData) {
                              List<Map<String, dynamic>> stores = snapshot.data!.docs.map((doc) => {'id': doc.id, 'name': doc['name'] as String}).toList();
                              return DropdownButtonFormField<String>(
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
                                value: storeId, // 修正点: 選択された店舗のIDをセットする
                                items: stores.map((store) {
                                  return DropdownMenuItem<String>(
                                    value: store['id'],
                                    child: Text(store['name']),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    storeId = value;
                                  });
                                },
                              );
                            } else {
                              return Text('No data available');
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 20, right: 20),
                child: Center(
                  child: Container(
                    width: 320,
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
                      onChanged: (value) {
                        setState(() {
                          price = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.only(top: 3, left: 45, right: 45),
                child: Container(
                  width: 320, // 横幅を指定
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3), // 枠線を追加
                    borderRadius: BorderRadius.circular(10), // 角丸にする
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10), // テキストと枠線の間に余白を追加
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '例 : おいしかったまた行きたい',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          review = value;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 70,),
              Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
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
                          color: Colors.blue,
                        ),
                        itemSize: 30,
                        onRatingUpdate: (rating) {
                          setState(() {
                            overallRating = rating;
                          });
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
                              color: Colors.blue,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              setState(() {
                                tasteRating = rating;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '衛生',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              setState(() {
                                hygieneRating = rating;
                              });
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
                              color: Colors.blue,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              setState(() {
                                atmosphereRating = rating;
                              });
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
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () {
                      postReview(); // レビューを投稿するメソッドを呼び出します
                      Navigator.pop(context);
                    },
                    child: Text(
                      'レビューを投稿',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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

  void postReview() {
    FirebaseFirestore.instance.collection('posts').add({
      'storeid': storeId, // Nullableに変更
      'discount': price,
      'review': review,
      'total': overallRating.toInt(),
      'taste': tasteRating,
      'hygiene': hygieneRating,
      'atmosphere': atmosphereRating,
      'userid': "BVMyTOqbcwbhzmv2jQkB",
      'image':'https://firebasestorage.googleapis.com/v0/b/group7-71de2.appspot.com/o/post_image%2F3.jpg?alt=media&token=715596b7-5a8f-446b-9387-b6b2ff9478a2',
    }).then((value) {
      print('レビューが投稿されました！');
      String postId = value.id; // 新しいドキュメントのIDを取得
      addToMyPosts(postId); // レビューをユーザーのマイポストに追加
    }).catchError((error) {
      print('エラーが発生しました: $error');
    });
  }

  void addToMyPosts(String postId) {
    FirebaseFirestore.instance.collection('users').doc('BVMyTOqbcwbhzmv2jQkB').update({
      'mypost': FieldValue.arrayUnion([postId]), // 新しいpostIdを配列に追加する
    }).then((value) {
      print('配列に追加されました！');
    }).catchError((error) {
      print('エラーが発生しました: $error');
    });
  }
}

