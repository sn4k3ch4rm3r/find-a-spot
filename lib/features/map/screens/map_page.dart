import 'package:find_a_spot/features/map/widgets/marker_widget.dart';
import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CollectionModel> spots = context.watch<List<CollectionModel>>();
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
            initialZoom: 8,
            initialCenter: LatLng(47.4978915, 19.0402333),
            interactionOptions: InteractionOptions(
              flags: ~InteractiveFlag.rotate,
            )),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.sn4k3ch4rm3r.find_a_spot',
          ),
          MarkerLayer(
              markers: spots.map(
            (spot) {
              return Marker(
                point: spot.coordinates,
                child: const MarkerWidget(),
              );
            },
          ).toList()),
          const RichAttributionWidget(attributions: [
            TextSourceAttribution(
              "OpenStreetMap contributors",
            )
          ])
        ],
      ),
    );
  }
}
