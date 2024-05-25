import 'package:find_a_spot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CreatePage extends StatelessWidget {
  final ImageProvider image;
  const CreatePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Future<ColorScheme> colorScheme = ColorScheme.fromImageProvider(provider: image, brightness: Theme.of(context).brightness);

    return FutureBuilder<ColorScheme>(
      future: colorScheme,
      builder: (context, snapshot) {
        return Theme(
          data: snapshot.hasData ? DynamicTheme.fromDynamicScheme(snapshot.data) : Theme.of(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(L10n.of(context)!.create),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(12),
                              child: Image(
                                image: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                icon: Icon(Icons.description_outlined),
                                label: Text('Caption'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const TextField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              icon: Icon(Icons.location_on_outlined),
                              label: Text('Location'),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.search,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: SizedBox(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FlutterMap(
                                  options: const MapOptions(
                                    interactionOptions: InteractionOptions(
                                      flags: InteractiveFlag.none,
                                    ),
                                    initialCenter: LatLng(47.4978915, 19.0402333),
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.sn4k3ch4rm3r.find_a_spot',
                                    ),
                                    MarkerLayer(markers: [
                                      Marker(
                                        point: const LatLng(47.4978915, 19.0402333),
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
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text(
                            "Submit",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
