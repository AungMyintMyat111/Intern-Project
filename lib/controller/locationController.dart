

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/check.dart';


class LocationController extends GetxController {
  Rx<Position?> currentLocation = Rx<Position?>(null);
  Future<void> fetchUsers() async {
    try {
      var response = await Dio().get('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/check');
      List<dynamic> jsonData = response.data;
      var users = jsonData;
      print(users[1]);
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = position;
    } catch (e) {
      print('Error: $e');
    }
  }

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
  void sendLocationToServer() async {
    Position? position = currentLocation.value;
    if (position != null) {
      final url = Uri.parse('http://10.103.1.65:7000/api/v1/mapCheck');
      final response = await http.post(
        url,
        body: json.encode({
          'lat': position.latitude,
          'lon': position.longitude,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Location sent successfully');
      } else {
        print('Failed to send location. Error: ${response.reasonPhrase}');
      }
    } else {
      print('Location not available');
    }
  }
}
