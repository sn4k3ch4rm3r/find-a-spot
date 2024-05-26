import 'dart:async';

import 'package:find_a_spot/create/models/location.dart';
import 'package:find_a_spot/create/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

class LocationSearch extends StatefulWidget {
  final LocationProvider provider;
  const LocationSearch({super.key, required this.provider});

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  Completer<void> _searchCompleter = Completer<void>();
  List<Location> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SearchAnchor(
        builder: (context, controller) {
          return TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              icon: const Icon(Icons.location_on_outlined),
              label: Text(L10n.of(context)!.locaiton),
              border: const OutlineInputBorder(),
            ),
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (value) {
              controller.openView();
            },
            textInputAction: TextInputAction.done,
          );
        },
        suggestionsBuilder: (context, controller) async {
          await _searchCompleter.future;
          _searchCompleter = Completer<void>();
          return searchResult.map((suggestion) {
            return ListTile(
              title: Text(suggestion.name),
              onTap: () {
                controller.closeView(suggestion.name);
                widget.provider.location = suggestion;
              },
            );
          });
        },
        textInputAction: TextInputAction.search,
        viewOnSubmitted: (value) {
          widget.provider.search(value).then((_) {
            setState(() {
              searchResult = widget.provider.searchResult;
            });
            _searchCompleter.complete();
          });
        },
        isFullScreen: false,
      );
    });
  }
}
