import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(Map());

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? currentPosition;
  late GoogleMapController mapController;
  late StreamSubscription<Position> positionStream;
  bool _isPermissionGranted = false;
  late GooglePlace googlePlace;

  @override
  void initState(){
    super.initState();
    _initMap();
    googlePlace = GooglePlace("AIzaSyDV1F8ytAuEWf");
  }

  Future<void> _initMap() async {
    await _requestLocationPermission();
    _getCurrentPosition();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        _isPermissionGranted = true;
      });
    }
  }

  void _getCurrentPosition() async {
    if (_isPermissionGranted) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = position;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isPermissionGranted){
    positionStream = Geolocator.getPositionStream().listen((Position? position) {
      setState(() {
        currentPosition = position;
      });
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            key: UniqueKey(),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentPosition?.latitude ?? 0,
                currentPosition?.longitude ?? 0, 
              ), // San Franciscoの座標
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            zoomControlsEnabled: false,
            myLocationEnabled: true,
          ),
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: _buildSearchBar(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '絞り込み',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '移動距離',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 130),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                              hintText: '検索',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              print('検索文字列: $value');
                            },
                          ),
                        ),
                      ],
                    ),
                    // 他の絞り込み項目も同様に追加
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.filter_alt_rounded),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '検索',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
        onChanged: (value) {
          print('検索文字列: $value');
        },
      ),
    );
  }
    Future<void> _showNearbyPlaces() async {
      if (currentPosition != null){
        final location = Location(
          lat: currentPosition!.latitude,
          lng: currentPosition!.longitude,
        );

    final result = await googlePlace.search.getNearBySearch(location, 1500, type: "restaurant"); // タイプを指定して検索

    if (result != null && result.results != null) {
      Set<Marker> _markers = {};
      for (var place in result.results!) {
        final marker = Marker(
          markerId: MarkerId(place.name ?? ''),
          position: LatLng(
            place.geometry?.location!.lat ?? 0, 
            place.geometry?.location!.lng ?? 0,
            ),
          infoWindow: InfoWindow(
            title: place.name ?? '',
            snippet: place.vicinity ?? '',
          ),
        );
        _markers.add(marker);
      }
      setState((){
        _markers = _markers.toSet();
      });
    }
    }
  }
}
