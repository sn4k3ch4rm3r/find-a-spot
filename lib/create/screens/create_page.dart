import 'package:find_a_spot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CreatePage extends StatelessWidget {
  final Image image;
  const CreatePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Future<ColorScheme> colorScheme = ColorScheme.fromImageProvider(provider: image.image, brightness: Theme.of(context).brightness);

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
                          ClipRRect(
                            borderRadius: BorderRadiusDirectional.circular(12),
                            child: image,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.description_outlined),
                                label: Text('Caption'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const TextField(
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
                                child: const Placeholder(),
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
