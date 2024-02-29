import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> getImageURL(String imagePath) async {
  try {
    Reference ref = storage.ref().child(imagePath);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print("Error getting download URL: $e");
    return "https://example.com/default-image.jpg";
  }
}

Future<void> main() async { // main 関数を非同期関数にする
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String imagePath = "gs://group7-71de2.appspot.com"; // 画像のパス
  String imageURL = await getImageURL(imagePath);
  print(imageURL); // imageURL を表示
}
