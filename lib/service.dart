import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirestoreService {
  final db = FirebaseFirestore.instance;


// ユーザーDB読み込み
  Future<List<String>> read_user(userID) async {
    final doc = await db.collection('users').doc(userID).get();
    if (doc.exists) {
      final userData = doc.data();
      final name = userData?['name']?.toString();
      final liked = userData?['liked']?.toString();
      final profileURL = userData?['profileURL']?.toString();


      List<String> userDataList = [];

      if (name != null) {
        userDataList.add(name);
      }
      if (liked != null) {
        userDataList.add(liked);
      }
      if (profileURL != null) {
        userDataList.add(profileURL);
      }

      return userDataList;
    } else {
      debugPrint('userID: $userID のドキュメントが見つかりませんでした');
      return [];
    }
  }

// ユーザーDBのmypostを参考にpostDBから画像のURLを配列で取ってくる
Future<List<String>> readUserPostImages(String userID) async {
  final doc = await db.collection('users').doc(userID).get();
  if (doc.exists) {
    final userData = doc.data();
    final mypost = List<String>.from(userData?['mypost'] ?? []);

    // 画像の URL を格納するリスト
    List<String> imageUrls = [];

    // mypost 配列の各 post ID に対応する画像の URL を取得
    for (String postId in mypost) {
      // Firestore から post ドキュメントを取得
      final postDoc = await db.collection('posts').doc(postId).get();
      if (postDoc.exists) {
        // post ドキュメントから画像の URL を取得してリストに追加
        final postData = postDoc.data();
        final imageUrl = postData?['image'];
        if (imageUrl != null) {
          imageUrls.add(imageUrl.toString());
        }
      }
    }
    return imageUrls;
  } else {
    debugPrint('userID: $userID のドキュメントが見つかりませんでした');
    return [];
  }
}

// postDBからデータを取ってくる
  Future<List<String>> read_post(postID) async {
  final doc = await db.collection('users').doc(postID).get();
  if (doc.exists) {
    final postData = doc.data();
    final userid = postData?['userid']?.toString();
    final storeid = postData?['storeid']?.toString();
    final discount = postData?['discount']?.toString();
    final review = postData?['review']?.toString();
    final taste = postData?['taste']?.toString();
    final atmosphere = postData?['atmosphere']?.toString();
    final hygiene = postData?['hygiene']?.toString();
    final image = postData?['image']?.toString();

    List<String> postDataList = [];

    if (userid != null) {
      postDataList.add(userid);
    }
    if (storeid != null) {
      postDataList.add(storeid);
    }
    if (discount != null) {
      postDataList.add(discount);
    }
    if (review != null) {
      postDataList.add(review);
    }
    if (taste != null) {
      postDataList.add(taste);
    }
    if (atmosphere != null) {
      postDataList.add(atmosphere);
    }
    if (hygiene != null) {
      postDataList.add(hygiene);
    }
    if (image != null) {
      postDataList.add(image);
    }

    return postDataList;
  } else {
    debugPrint('userID: $postID のドキュメントが見つかりませんでした');
    return [];
  }
}


// storeDBからデータを取ってくる
  Future<List<String>> read_store(storeID) async {
  final doc = await db.collection('stores').doc(storeID).get();
  if (doc.exists) {
    final postData = doc.data();
    final address = postData?['address']?.toString();
    final atmosphere = postData?['atmosphere']?.toString();
    final averageTime = postData?['averageTime']?.toString();
    final detail = postData?['detail']?.toString();
    final hygiene = postData?['hygiene']?.toString();
    final liked = postData?['liked']?.toString();
    final name = postData?['name']?.toString();
    final open = postData?['open']?.toString();
    final taste = postData?['taste']?.toString();
    final total = postData?['total']?.toString();
    final storeURL = postData?['storeURL']?.toString();

    List<String> storeDataList = [];

    if (storeURL != null) {
      storeDataList.add(storeURL);
    }
    if (name != null) {
      storeDataList.add(name);
    }
    if (detail != null) {
      storeDataList.add(detail);
    }
    if (total != null) {
      storeDataList.add(total);
    }
    if (taste != null) {
      storeDataList.add(taste);
    }
    if (hygiene != null) {
      storeDataList.add(hygiene);
    }
    if (atmosphere != null) {
      storeDataList.add(atmosphere);
    }
    if (liked != null) {
      storeDataList.add(liked);
    }
    if (address != null) {
      storeDataList.add(address);
    }
    if (averageTime != null) {
      storeDataList.add(averageTime);
    }
    if (open != null) {
      storeDataList.add(open);
    }

    return storeDataList;
  } else {
    debugPrint('userID: $storeID のドキュメントが見つかりませんでした');
    return [];
  }
}

// storeDBのpostdを参考にpostDBから画像のURLを配列で取ってくる
Future<List<String>> storePostdImages(String storeID) async {
  final doc = await db.collection('stores').doc(storeID).get();
  if (doc.exists) {
    final storeData = doc.data();
    final mypost = List<String>.from(storeData?['postd'] ?? []);

    // 画像の URL を格納するリスト
    List<String> imageUrls = [];

    // mypost 配列の各 post ID に対応する画像の URL を取得
    for (String postId in mypost) {
      // Firestore から post ドキュメントを取得
      final postDoc = await db.collection('posts').doc(postId).get();
      if (postDoc.exists) {
        // post ドキュメントから画像の URL を取得してリストに追加
        final postData = postDoc.data();
        final imageUrl = postData?['image'];
        if (imageUrl != null) {
          imageUrls.add(imageUrl.toString());
        }
      }
    }
    return imageUrls;
  } else {
    debugPrint('userID: $storeID のドキュメントが見つかりませんでした');
    return [];
  }
}




  Future<List<String>> getAllImageURLs() async {
    try {
      // Firebase Storageのインスタンスを取得
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

      // 画像が保存されているディレクトリの参照を取得
      firebase_storage.Reference ref = storage.ref(); // ディレクトリのルート

      // ディレクトリ内のファイル一覧を取得
      firebase_storage.ListResult result = await ref.listAll();

      // ファイル一覧から各画像のダウンロードURLを取得して配列に格納
      List<String> imageURLs = [];
      await Future.forEach(result.items, (firebase_storage.Reference reference) async {
        String downloadURL = await reference.getDownloadURL();
        imageURLs.add(downloadURL);
      });

      // 画像のダウンロードURLの配列を返す
      return imageURLs;
    } catch (e) {
      // エラーが発生した場合は空の配列を返す
      print('画像のダウンロードURL一覧の取得中にエラーが発生しました: $e');
      return [];
    }
  }
}
