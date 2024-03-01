import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(Map());

class Map extends StatelessWidget {
  const Map({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
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
  Set<Marker> _markers = {};
  TextEditingController _searchController = TextEditingController();
  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  late Set<Polyline> _polylines;
  List<LatLng> _convertToLatLng(List<PointLatLng> points) {
  List<LatLng> result = [];
  for (PointLatLng point in points) {
    result.add(LatLng(point.latitude, point.longitude));
  }
  return result;
}

  @override
  void initState() {
    super.initState();
    _initMap();
    googlePlace = GooglePlace("AIzaSyDV1F8ytAuEWf-MnXWFsJ6odtshHmwekfI"); // Google Places APIキーを追加してください
    polylinePoints = PolylinePoints();
    _polylines = {};
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
    if (_isPermissionGranted) {
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
              ),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: _buildSearchBar(),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () async {
        final selectedPlace = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(currentPosition: currentPosition),
          ),
        );
        if (selectedPlace != null && selectedPlace is AutocompletePrediction) {
          _showRoute(selectedPlace);
        }
      },
      child: Container(
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
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 8.0),
            Text('検索'),
          ],
        ),
      ),
    );
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isNotEmpty) {
      final result = await googlePlace.search.getTextSearch(
        query,
        location: Location(
          lat: currentPosition!.latitude,
          lng: currentPosition!.longitude,
        ),
        radius: 1500,
      );

      if (result != null && result.results != null) {
        _markers.clear();
        for (var place in result.results!) {
          // Check if the place type is 'restaurant', 'cafe', or 'bar'
          if (place.types!.contains('restaurant') || place.types!.contains('cafe') || place.types!.contains('bar')) {
            final marker = Marker(
              markerId: MarkerId(place.placeId ?? ''),
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
        }
        setState(() {
          _markers = _markers.toSet();
        });
      }
    }
  }

  void _showRoute(AutocompletePrediction selectedPlace) async {
    final result = await googlePlace.details.get(selectedPlace.placeId!);
    if (result != null &&
        result.result != null &&
        result.result!.geometry != null &&
        result.result!.geometry!.location != null) {
      final location = result.result!.geometry!.location!;
      LatLng destinationLatLng = LatLng(location.lat ?? 0, location.lng ?? 0);

      _markers.clear();
      _getPolylineCoordinates(
          currentPosition!.latitude,
          currentPosition!.longitude,
          destinationLatLng.latitude,
          destinationLatLng.longitude);
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('destination'),
            position: destinationLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              title: selectedPlace.description,
            ),
          ),
        );
      });
    }
  }

    Future<void> _getPolylineCoordinates(double startLat, double startLng, double destLat, double destLng) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDV1F8ytAuEWf-MnXWFsJ6odtshHmwekfI',
      PointLatLng(startLat, startLng),
      PointLatLng(destLat, destLng),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polylines.clear(); // 古い経路をクリアする
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          width: 5,
          color: Colors.blue,
          points: _convertToLatLng(result.points),
        ));
      });
    }
    _addPolyline();
  }


  void _addPolyline() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("poly"),
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    setState(() {
      _polylines.add(polyline);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class SearchScreen extends StatelessWidget {
  final Position? currentPosition;

  const SearchScreen({Key? key, required this.currentPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchForm(currentPosition: currentPosition),
    );
  }
}

class SearchForm extends StatefulWidget {
  final Position? currentPosition;

  const SearchForm({Key? key, required this.currentPosition}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace("AIzaSyDV1F8ytAuEWf-MnXWFsJ6odtshHmwekfI"); // Google Places APIキーを追加してください
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              if (predictions.length > 0 && mounted) {
                                setState(() {
                                  predictions = [];
                                });
                              }
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              color: Colors.grey[500],
                              icon: Icon(Icons.arrow_back_ios_new),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            hintText: '場所を検索',
                            hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = predictions[index];
                    return Card(
                      child: ListTile(
                        title: Text(prediction.description.toString()),
                        onTap: () {
                          // Return the selected prediction
                          Navigator.pop(context, prediction);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    final result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!.where((prediction) {
          // Check if the place type is 'restaurant', 'cafe', or 'bar'
          return prediction.types!.contains('restaurant') ||
              prediction.types!.contains('cafe') ||
              prediction.types!.contains('bar');
        }).toList();
      });
    }
  }
}
