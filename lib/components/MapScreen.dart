import 'package:AARUUSH_CONNECT/Screens/Events/eventScreen/controllers/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class Mapscreen extends StatefulWidget {
  final String? Lattitude;
  final String? Longitude;
  final String? location;
  Mapscreen({super.key, this.Lattitude, this.Longitude, this.location});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  final MapController _mapController = MapController();
  EventsController eventController = Get.find<EventsController>();

  @override
  void initState() {
    super.initState();
    // Any additional setup if required
  }

  @override
  void dispose() {
    _mapController.dispose();
    eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var coordinates;
    if (widget.Lattitude != null && widget.Longitude != null) {
      coordinates = LatLng(
          double.parse(widget.Lattitude!), double.parse(widget.Longitude!));
    }

    return FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialRotation: 20,
          initialZoom: 17,
          maxZoom: 21,
          onTap: (val, Coordinates) {
            if (Coordinates != null) {
              eventController.openMapWithLocation(
                  widget.Lattitude!, widget.Longitude!);
            }
          },
          initialCenter: coordinates,
          interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
        ),
        children: [
          map,
          widget.Lattitude != null
              ? MarkerLayer(markers: [
                  Marker(
                      point: coordinates,
                      width: 100,
                      height: 100,
                      rotate: false,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                              child: Text(
                            widget.location ?? '',
                            style: const TextStyle(fontSize: 40),
                          )),
                          const Icon(
                            Icons.location_pin,
                            size: 30,
                            color: Colors.red,
                          ),
                        ],
                      )),
                ])
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: LogoSourceAttribution(
              const Icon(Icons.center_focus_strong_rounded),
              onTap: () {
                _mapController.move(coordinates, 17);
              },
              tooltip: "CLick to centre the map",
            ),
          )
        ]);
  }

  Widget _darkModeTileBuilder(
    BuildContext context,
    Widget tileWidget,
    TileImage tile,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
        -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
        0, 0, 0, 1, 0, // Alpha channel
      ]),
      child: tileWidget,
    );
  }

  TileLayer get map => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        maxNativeZoom: 15,
        maxZoom: 21,
        retinaMode: true,
        userAgentPackageName: "dev.fleaflet.flutter_map.example",
        tileBuilder: _darkModeTileBuilder,
      );
}
