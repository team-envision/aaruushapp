import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Any additional setup if required
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options:  MapOptions(
        // initialCenter: LatLng(12.8240104753402, 80.0457505142571), // Ensure this is the correct center coordinate
        zoom: 5
        // interactionOptions: InteractionOptions(flags: ~InteractiveFlag.all),
      ),
      children: [
        MarkerLayer(markers: [Marker(point:LatLng(12.8240104753402, 80.0457505142571),
            width:60,
          height: 60,
          rotateAlignment: Alignment.centerLeft,
          builder:(context){
          return GestureDetector(
              onTap: (){},
              child: Icon(
                Icons.location_pin,
                size: 60,
                color: Colors.red,
              ));
          }
        )]),
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          maxNativeZoom: 19,
          // zoomReverse: true,
          userAgentPackageName: "dev.fleaflet.flutter_map.example",
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => _launchUrl('https://openstreetmap.org/copyright'),
            ),
            // Add more attributions or images if necessary
          ],
        ),
      ],
    );
  }
}
