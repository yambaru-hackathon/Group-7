import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RouteDisplayScreen(),
    );
  }
}

class RouteDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Display'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Firestoreから座標を取得
            LatLng destinationFromFirestore = await getDestinationFromFirestore();
            // 取得した座標を使って画面遷移
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(destination: destinationFromFirestore),
              ),
            );
          },
          child: Text('経路を表示する'),
        ),
      ),
    );
  }

  // Firestoreから座標を取得するメソッド
  Future<LatLng> getDestinationFromFirestore() async {
    // ここでFirestoreから座標を取得する処理を実行する
    // 例えば、Firestoreのコレクションやドキュメントから座標を取得して返す
    // 今回はダミーの座標を返す
    return const LatLng(26.3764, 127.8051);
  }
}

class MapScreen extends StatefulWidget {
  final LatLng destination;

  MapScreen({required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const String API_KEY = "AIzaSyDV1F8ytAuEWf-MnXWFsJ6odtshHmwekfI"; // Google Maps PlatformのAPIキーを設定

  late GoogleMapController mapController;
  final Set<Polyline> _polyline = {};
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // 現在地の取得
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _getRoutes(); // 現在地を取得した後に経路を取得するメソッドを呼び出す
    });
  }

  // ルート表示データ取得
  Future<void> _getRoutes() async {
    List<LatLng> _points = await _createPolyline(_currentLocation, widget.destination);
    setState(() {
      _polyline.add(Polyline(
        polylineId: const PolylineId("Route"),
        visible: true,
        color: Colors.blue,
        width: 5,
        points: _points,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  // マップの作成
  Widget _createMap() {
    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: widget.destination, zoom: 9),
      polylines: _polyline,
      markers: {
        Marker(markerId: const MarkerId("destination"), position: widget.destination),
      },
    );
  }

  // ルート表示
  Future<List<LatLng>> _createPolyline(LatLng start, LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoordinates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: _createMap(),
    );
  }
}
