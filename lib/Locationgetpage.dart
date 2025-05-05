import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/Home.dart';
import 'package:task1/Services/Api_services.dart';
import 'package:task1/address.dart';

class Locationgetpage extends StatefulWidget {
  const Locationgetpage({super.key});

  @override
  _LocationgetpageState createState() => _LocationgetpageState();
}

class _LocationgetpageState extends State<Locationgetpage> {
  final loc.Location location = loc.Location();
  bool _isLoading = false;
  loc.LocationData? _locationData;
  String? fullLocation;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkPermission(BuildContext context) async {
    bool permissionGranted = false;

    if (Platform.isAndroid || Platform.isIOS) {
      var locationPermission = await Permission.location.status;

      if (locationPermission.isGranted) {
        permissionGranted = true;
      } else {
        var requestResult = await Permission.location.request();
        if (requestResult.isGranted) {
          permissionGranted = true;
        } else {
          _showPermissionDialog(context);
        }
      }
    }

    return permissionGranted;
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content:
              const Text('Please enable location permissions in settings.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<loc.LocationData?> tryGetLocationWithRetry(int retries) async {
    for (int i = 0; i < retries; i++) {
      try {
        return await location.getLocation();
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    return null;
  }

  Future<void> getLocation() async {
    try {
      setState(() => _isLoading = true);

      _locationData = await tryGetLocationWithRetry(3);

      if (_locationData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Unable to fetch location. Please try again.")),
        );
        return;
      }

      List<Placemark> placemarks = await placemarkFromCoordinates(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );

      Placemark place = placemarks.first;
      fullLocation =
          "${place.subLocality ?? ''}, ${place.locality ?? ''}".trim();
      String address =
          "${place.street}, ${place.subLocality}, ${place.locality}, "
          "${place.administrativeArea}, ${place.postalCode}, ${place.country}";

      print("📍 Address: $address");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('location', fullLocation ?? "");
      await prefs.setString('place', place.locality ?? "");
      await prefs.setString('area', place.subLocality ?? "");
      await prefs.setString('state', place.administrativeArea ?? "");
    } catch (e) {
      print("❌ Location error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/Icon Marker.png',
                  height: 80,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hello, nice to meet you!',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Set your current location and get started',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Ubuntu',
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Fetching address...',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        bool permissionGranted = await checkPermission(context);

                        if (permissionGranted) {
                          await Future.delayed(
                              const Duration(milliseconds: 500));

                          bool serviceEnabled = await location.serviceEnabled();
                          if (!serviceEnabled) {
                            serviceEnabled = await location.requestService();
                            if (serviceEnabled) {
                              await Future.delayed(const Duration(
                                  seconds: 2)); // wait for GPS to initialize
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Please enable GPS to continue"),
                                ),
                              );
                              return;
                            }
                          }

                          await getLocation();

                          if (fullLocation != null) {
                            try {
                              await Apiservices().locationupdate(fullLocation!);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Address()),
                              );
                            } catch (e) {
                              print("❌ API error: $e");
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Location fetch failed"),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB001D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 58),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Icon Location.png',
                            height: 20,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Use current location',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                'We only access your location while you are using this incredible app',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
