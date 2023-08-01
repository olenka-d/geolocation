import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  bool _isLocationServiceEnabled = false;
  StreamSubscription<Position>? _positionStreamSubscription;

  Position? get currentPosition => _currentPosition;
  bool get isLocationServiceEnabled => _isLocationServiceEnabled;

  LocationProvider() {
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (_isLocationServiceEnabled) {
      _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
        _currentPosition = position;
        notifyListeners();
      });
    }
  }

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }
}
