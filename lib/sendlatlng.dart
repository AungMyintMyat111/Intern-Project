import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationSender(),
    );
  }
}

class LocationSender extends StatefulWidget {
  @override
  _LocationSenderState createState() => _LocationSenderState();
}

class _LocationSenderState extends State<LocationSender> {
  Position? currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Sender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentPosition != null
                  ? 'Latitude: ${currentPosition!.latitude}, Longitude: ${currentPosition!.longitude}'
                  : 'Getting current location...',
            ),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: Text('Get Location'),
            ),
            ElevatedButton(
              onPressed: () {
                if (currentPosition != null) {
                  _sendLocationToServer(currentPosition!);
                } else {
                  print('Location not available');
                }
              },
              child: Text('Send Location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _sendLocationToServer(Position position) async {
    final url = Uri.parse('https://663077fcc92f351c03d9ee40.mockapi.io/apitest/myint');
    final response = await http.post(
      url,
      body: json.encode({
        'lat': position.latitude,
        'lon': position.longitude,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Location sent successfully');
    } else {
      print('Failed to send location. Error: ${response.reasonPhrase}');
    }
  }
}
