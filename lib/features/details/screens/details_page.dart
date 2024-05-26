import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

// Disclaimer: ez így leadás előtt egy olyan fél órával készült, úgyhogy ez már csak nagyjából
// az alkalmazásban megtalálható többi widgetből lett össze ollózva.

class DetailsPage extends StatelessWidget {
  final CollectionModel spot;
  const DetailsPage({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    NetworkImage imageProvider = NetworkImage(spot.imageUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(spot.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Hero(
                  tag: spot.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: imageProvider,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  spot.caption,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: FlutterMap(
                          options: MapOptions(
                            interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.none,
                            ),
                            initialCenter: spot.coordinates,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.sn4k3ch4rm3r.find_a_spot',
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                point: spot.coordinates,
                                child: Transform.translate(
                                  offset: const Offset(0, -12),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ]),
                            const RichAttributionWidget(attributions: [
                              TextSourceAttribution(
                                "OpenStreetMap contributors",
                              )
                            ])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(spot.address),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("GPS: ${spot.coordinates.latitude}, ${spot.coordinates.longitude}"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
