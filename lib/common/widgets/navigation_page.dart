import 'package:find_a_spot/collection/collection.dart';
import 'package:find_a_spot/common/providers/navigation_provider.dart';
import 'package:find_a_spot/map/screens/map_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(builder: (contex, navigationProvider, child) {
      return IndexedStack(
        index: navigationProvider.pageIndex,
        children: const [
          CollectionPage(),
          MapPage()
        ],
      );
    });
  }
}
