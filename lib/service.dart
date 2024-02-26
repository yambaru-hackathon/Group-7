import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



/// ファイアーストアと通信するクラス
class FirestoreService {
  final db = FirebaseFirestore.instance;


  /* Read 読み出し */
Future<List<String>> read(userID) async {
  final doc = await db.collection('users').doc(userID).get();
  // ドキュメントが存在するかどうかを確認
  if (doc.exists) {
    // data() メソッドを使用してデータにアクセス
    final userData = doc.data();
    final name = userData?['name']?.toString();
    final liked = userData?['liked']?.toString();
    final posts = userData?['posts']?.toString();
    
    List<String> userDataList = [];

    // nullチェックを追加
    if (name != null) {
      userDataList.add(name);
    }
    if (liked != null) {
      userDataList.add(liked);
    }
    if (posts != null) {
      userDataList.add(posts);
    }

    return userDataList;
  } else {
    // ドキュメントが存在しない場合の処理
    debugPrint('userID: $userID のドキュメントが見つかりませんでした');
    return []; // ドキュメントが存在しない場合は空のリストを返す
  }
}

// Firestorage に画像をアップロードする関数
Future<void> uploadImageToFirebaseStorage(String imagePath) async {
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('images')
      .child(imagePath);

  firebase_storage.UploadTask uploadTask = ref.putFile(File(imagePath));
  firebase_storage.TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
  
  // アップロード後の画像の URL を取得
  String downloadURL = await snapshot.ref.getDownloadURL();

  await FirebaseFirestore.instance.collection('images').add({
    'url': downloadURL,
  });
}

  // /* Read 応用 1~3 */
  // Future<void> read123() async {
  //   final snapshot = await db
  //       .collection('songs')
  //       .where('genre', isEqualTo: 'J-POP') // J-POPのみ
  //       .orderBy('released') // リリース年順
  //       .limit(3) // 3曲
  //       .get();

  //   // 見つかった曲を全部つなげて文字にする
  //   final docs = snapshot.docs.map(
  //     (doc) => doc.data().toString(),
  //   );
  //   final songs = docs.join();
  //   debugPrint(songs);
  // }
}
