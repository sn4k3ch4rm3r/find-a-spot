import 'package:find_a_spot/create/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPreview extends StatelessWidget {
  final LocationProvider provider;
  const LocationPreview({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    LatLng center = provider.location?.coordinates ?? const LatLng(47.4978915, 19.0402333);
    MapController controller = MapController();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        controller.move(center, 13);
      },
    );
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: center,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sn4k3ch4rm3r.find_a_spot',
        ),
        MarkerLayer(markers: [
          Marker(
            point: center,
            child: Transform.translate(
              offset: const Offset(0, -12),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          )
        ])
      ],
    );
  }
}
