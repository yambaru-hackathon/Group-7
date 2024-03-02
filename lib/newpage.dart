import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String? storeId;
  String price = '';
  String review = '';
  double overallRating = 0.0;
  double tasteRating = 0.0;
  double hygieneRating = 0.0;
  double atmosphereRating = 0.0;
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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
                      _buildImagePreview(),
                      SizedBox(height: 20),
                      // Rest of the code remains the same
                      // Continue building UI here...
                    ],
                  ),
                ),
              ),
              // Rest of the code remains the same
              // Continue building UI here...
            ],
          ),
        ),
      ),
    );
  }

  Future<String> _uploadImageToFirebase() async {
    if (_image == null) {
      return ''; // No image selected
    }

    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('post_images/${DateTime.now()}');
    await firebaseStorageRef.putFile(_image!);
    return await firebaseStorageRef.getDownloadURL();
  }

  void postReview() async {
    String imageUrl = await _uploadImageToFirebase();

    FirebaseFirestore.instance.collection('posts').add({
      'storeid': storeId,
      'discount': price,
      'review': review,
      'total': overallRating.toInt(),
      'taste': tasteRating,
      'hygiene': hygieneRating,
      'atmosphere': atmosphereRating,
      'userid': "BVMyTOqbcwbhzmv2jQkB",
      'image': imageUrl,
    }).then((value) {
      print('レビューが投稿されました！');
      String postId = value.id;
      addToMyPosts(postId);
    }).catchError((error) {
      print('エラーが発生しました: $error');
    });
  }

  void addToMyPosts(String postId) {
    FirebaseFirestore.instance.collection('users').doc('BVMyTOqbcwbhzmv2jQkB').update({
      'mypost': FieldValue.arrayUnion([postId]),
    }).then((value) {
      print('配列に追加されました！');
    }).catchError((error) {
      print('エラーが発生しました: $error');
    });
  }
}
