import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ShellNavigatorPage extends StatelessWidget {
  final GoRouterState state;
  final StatefulNavigationShell child;

  const ShellNavigatorPage({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        height: 65,
        selectedIndex: state.toIndex(),
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/');
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
                            context.push('/create');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
              break;
            case 2:
              context.go('/map');
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
      ),
    );
  }
}

extension on GoRouterState {
  int toIndex() {
    switch (matchedLocation) {
      case '/':
        return 0;
      case '/map':
        return 2;
      default:
        return 0;
    }
  }
}
