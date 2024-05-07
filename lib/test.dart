import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class checkin extends StatefulWidget {
  const checkin({super.key});
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
  print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }



  @override
  State<checkin> createState() => _checkinState();
}

class _checkinState extends State<checkin> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



