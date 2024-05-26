import 'dart:async';
import 'package:find_a_spot/features/create/providers/creation_provider.dart';
import 'package:find_a_spot/features/create/widgets/location_preview.dart';
import 'package:find_a_spot/features/create/widgets/location_search.dart';
import 'package:find_a_spot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider = FileImage(context.read<CreationProvider>().imageFile);
    Future<ColorScheme> colorScheme = ColorScheme.fromImageProvider(provider: imageProvider, brightness: Theme.of(context).brightness);

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
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (value) {
                                context.read<CreationProvider>().caption = value;
                              },
                              decoration: InputDecoration(
                                icon: const Icon(Icons.description_outlined),
                                label: Text(L10n.of(context)!.caption),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          LocationSearch(
                            provider: context.watch<CreationProvider>(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: SizedBox(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: LocationPreview(
                                  provider: context.watch<CreationProvider>(),
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
                          onPressed: () {
                            context.read<CreationProvider>().submit().then((_) {
                              if (context.read<CreationProvider>().uploadState == UploadState.done) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(L10n.of(context)!.uploadSuccessful),
                                  ),
                                );
                              }
                            });
                          },
                          child: context.watch<CreationProvider>().uploadState == UploadState.uploading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                )
                              : Text(
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
  }
}
