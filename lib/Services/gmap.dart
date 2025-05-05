import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart';
import 'package:task1/profilletap.dart';

class Gmap extends StatefulWidget {
  const Gmap({super.key});

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  Location location = Location();
  LocationData? _locationData;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      if (mounted) {
        setState(() {
          _locationData = locationData;
          _updateMarkers();
          _fetchRouteWithDio(
            LatLng(locationData.latitude!, locationData.longitude!),
            LatLng(10.7867, 78.7047), // Example destination
          );
        });
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void _updateMarkers() {
    if (_locationData == null) return;

    LatLng userLocation =
        LatLng(_locationData!.latitude!, _locationData!.longitude!);
    LatLng destination = LatLng(10.7867, 78.7047);

    setState(() {
      _markers.clear();
      _polylines.clear();

      _markers.add(Marker(
        markerId: const MarkerId("current_location"),
        position: userLocation,
        infoWindow: const InfoWindow(title: "My Location"),
        icon: BitmapDescriptor.defaultMarker,
      ));

      _markers.add(Marker(
        markerId: const MarkerId("destination"),
        position: destination,
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    });
  }

  Future<void> _fetchRouteWithDio(LatLng start, LatLng end) async {
    String apiKey =
        'AIzaSyCEjig6IQniMUf2OKaynMS8Nh9qyWbAKuM'; // Replace with your API key
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

    try {
      var dio = Dio();
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        print(
            "###################################################################");
        print(response.data);
        print('Trying to load asset: assets/back-icon.png');
        print(
            "###################################################################");
        var data = response.data;
        List<LatLng> routePoints = [];

        for (var step in data['routes'][0]['legs'][0]['steps']) {
          routePoints.add(LatLng(
              step['start_location']['lat'], step['start_location']['lng']));
          routePoints.add(
              LatLng(step['end_location']['lat'], step['end_location']['lng']));
        }

        setState(() {
          polylineCoordinates = routePoints;
          _polylines.add(Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ));
        });
      }
    } catch (e) {
      print("Error fetching route with Dio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: const Text('Gmap')),
        body: _locationData == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          _locationData!.latitude!, _locationData!.longitude!),
                      zoom: 16.5,
                    ),
                    minMaxZoomPreference:
                        const MinMaxZoomPreference(16.5, 16.5),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      _mapController!
                          .setMapStyle(Utils.mapStyle); // Apply Map Style
                    },
                    markers: _markers,
                    polylines: _polylines,
                    myLocationEnabled: true,
                    style: Utils.mapStyle,
                  ),
                  Positioned(
                    top: 45, // Adjust top position
                    left: 15, // Adjust left position
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white, // Background Color
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back,
                              color: Colors.black, size: 24),
                        ),
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.25, // Initial height (20% of screen)
                    minChildSize: 0.25, // Minimum height (10% of screen)
                    maxChildSize: 0.6, // Maximum height (80% of screen)
                    builder: (context, scrollController) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Center(
                                child: Image.asset('assets/line26.png',
                                    width: 75)), // Drag Icon
                            SizedBox(height: 20),

                            Container(
                              padding: EdgeInsets.all(10),
                              //color: Color(0xFFF6F6F6),
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: Image(
                                    image:
                                        AssetImage('assets/costomericon.png')),
                                title: Text(
                                  'Jackson',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  'Customer',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF747474)),
                                ),
                                trailing: SizedBox(
                                  width: 49,
                                  height: 50,
                                  child: Image(
                                      image: AssetImage(
                                    'assets/Callbutton.png',
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(children: [
                                  Row(children: [
                                    Text(
                                      'Advance paid',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹500",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF747474),
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: [
                                    Text(
                                      'Balance amount',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Spacer(),
                                    Text(
                                      "₹1000",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF747474),
                                          fontWeight: FontWeight.w600),
                                    )
                                  ])
                                ]),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.left,
                                      'Enter OTP',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: OtpTextField(
                                        alignment: Alignment.centerLeft,
                                        fieldWidth: 50,
                                        fieldHeight: 52,
                                        numberOfFields: 4,
                                        borderColor: Colors.grey,
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        focusedBorderColor: Colors.blue,
                                        showFieldAsBox: true,
                                        // margin: EdgeInsets.only(
                                        //     left: 30),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        // Box-style OTP fields
                                        onSubmit: (code) {
                                          print("OTP Entered: ");
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                                //margin: EdgeInsets.only(left: 10, right: 16),
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: Duration(
                                            milliseconds:
                                                300), // Animation Speed
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Profilletap(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(
                                              1.0, 0.0); // Start from Right
                                          const end = Offset
                                              .zero; // End at Normal Position
                                          const curve = Curves.easeInOut;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Order Delivered',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Color(0xFFEB001D),
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ));
  }
}

class Utils {
  static String mapStyle = '''
[
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
''';
}
