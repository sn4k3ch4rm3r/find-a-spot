import 'dart:async';
import 'package:find_a_spot/create/models/location.dart';
import 'package:find_a_spot/create/providers/location_provider.dart';
import 'package:find_a_spot/create/widgets/location_preview.dart';
import 'package:find_a_spot/create/widgets/location_search.dart';
import 'package:find_a_spot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  final ImageProvider image;
  const CreatePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Future<ColorScheme> colorScheme = ColorScheme.fromImageProvider(provider: image, brightness: Theme.of(context).brightness);

    return ChangeNotifierProvider<LocationProvider>(
      create: (context) => LocationProvider(),
      builder: (context, snapshot) {
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextField(
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.description_outlined),
                                    label: Text(L10n.of(context)!.caption),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              LocationSearch(
                                provider: context.watch<LocationProvider>(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: LocationPreview(
                                      provider: context.watch<LocationProvider>(),
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
                              child: Text(
                                L10n.of(context)!.submit,
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
      },
    );
  }
}
