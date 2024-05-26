import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:find_a_spot/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionCard extends StatelessWidget {
  final CollectionModel spot;
  const CollectionCard({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    NetworkImage imageProvider = NetworkImage(spot.imageUrl);
    Future<ColorScheme> colorScheme = ColorScheme.fromImageProvider(provider: imageProvider, brightness: Theme.of(context).brightness);

    return FutureBuilder<ColorScheme>(
      future: colorScheme,
      builder: (context, snapshot) {
        return Theme(
          data: snapshot.hasData ? DynamicTheme.fromDynamicScheme(snapshot.data) : Theme.of(context),
          child: Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                context.push('/details', extra: spot);
              },
              child: Card(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: [
                    Hero(
                      tag: spot.imageUrl,
                      child: Image(
                        image: imageProvider,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  spot.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            spot.caption,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
