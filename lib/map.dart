import 'dart:async';
import 'package:circlemap/show%20time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'controller/checkController.dart';
import 'controller/locationController.dart';
import 'controller/timeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    locationController.handleLocationPermission();
  }


  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _marker = {
    const Marker(
        markerId: MarkerId('Times City'),
        position: LatLng(16.81605105, 96.12887631),
        infoWindow: InfoWindow(
          title: 'Times City',
          snippet: 'Office Tower',
        )
    )
  };
  static const CameraPosition kGoogle = CameraPosition(
    target: LatLng(16.81605105, 96.12887631),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F9D58),
        title: const Text("Google Maps in Flutter"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: GoogleMap(
        
        
                  initialCameraPosition: kGoogle,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _marker,
                circles:{
                    Circle(
                       circleId: CircleId("1"),
                         radius: 789,
                        strokeColor: Colors.lightBlue,
                       strokeWidth: 1,
                        fillColor: Colors.lightBlue.withOpacity(0.5), center:LatLng(16.81605105, 96.12887631),
        
                )},
              ),
            ),
                      Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.input),
                    iconSize: 80,
                    onPressed: () {
                      locationController.currentLocation.value !=null
                      ? locationController.sendLocationToServer()
                     :locationController.getCurrentLocation();
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.outbox),
                    iconSize: 80,
                    onPressed: () {

                      // dateTimeController.sendDateTimeToServer();
                      checkConditionAndPerformAction();
                    },
                  ),
        
          ],
        ),
                      ),
        ],
            ),
      ),
    );
  }
}


