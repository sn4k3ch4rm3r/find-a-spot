import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  final String imgUrl;
  const CollectionCard({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    NetworkImage imageProvider = NetworkImage(imgUrl);
    Future<ColorScheme> scheme = ColorScheme.fromImageProvider(provider: imageProvider, brightness: Theme.of(context).brightness);
    return FutureBuilder<ColorScheme>(
        future: scheme,
        builder: (context, snapshot) {
          ColorScheme colorScheme = snapshot.data ?? Theme.of(context).colorScheme;
          return Card(
            color: colorScheme.surfaceContainerHigh,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Image(
                  image: imageProvider,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                "Budapest, HU",
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet.",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Score",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.primary,
                                ),
                          ),
                          Text(
                            "224",
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
