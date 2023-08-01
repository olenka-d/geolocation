import 'package:flutter/material.dart';
import 'package:geolocation/permission_location.dart';
import 'package:provider/provider.dart';
import 'location_provider.dart';


class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationProvider>(
      create: (_) => LocationProvider(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Geolocation'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locationProvider.currentPosition != null
                      ? 'Поточне місцезнаходження: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude}'
                      : 'Очікування поточних координат...',
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        LocationPermissionHelper.requestLocationPermission(context);
                        print(locationProvider.currentPosition?.latitude);
                      },
                      child: Text('Почати'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<LocationProvider>(context, listen: false).stopLocationUpdates();
                      },
                      child: Text('Зупинити'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
