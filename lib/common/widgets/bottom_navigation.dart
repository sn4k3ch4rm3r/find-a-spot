import 'package:find_a_spot/common/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 65,
      selectedIndex: Provider.of<NavigationProvider>(context).pageIndex,
      onDestinationSelected: (index) {
        NavigationProvider navProvider = Provider.of<NavigationProvider>(context, listen: false);
        switch (index) {
          case 0:
            navProvider.pageIndex = 0;
            break;
          case 1:
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.photo_camera),
                        title: const Text('Take a Picture'),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement taking a picture
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Pick from Gallery'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('/create');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
            break;
          case 2:
            navProvider.pageIndex = 1;
            break;
        }
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.collections_outlined),
          selectedIcon: const Icon(Icons.collections),
          label: L10n.of(context)!.collection,
        ),
        NavigationDestination(
          icon: const Icon(Icons.add_box_outlined),
          selectedIcon: const Icon(Icons.add_box),
          label: L10n.of(context)!.create,
        ),
        NavigationDestination(
          icon: const Icon(Icons.map_outlined),
          selectedIcon: const Icon(Icons.map),
          label: L10n.of(context)!.map,
        )
      ],
    );
  }
}
