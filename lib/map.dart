import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(home: MyMap()));
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition( //マップの初期位置を指定
            zoom: 17,                         //ズーム
            target: LatLng(35.0, 135.0),     //経度,緯度
            tilt: 45.0,                     //上下の角度
            bearing: 90.0),                //指定した角度だけ回転する
      ),
    );
  }
}