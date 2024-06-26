import 'dart:io';

import 'package:find_a_spot/features/create/create.dart';
import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:find_a_spot/features/shell_navigator/providers/collection_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ShellNavigatorPage extends StatelessWidget {
  final GoRouterState state;
  final StatefulNavigationShell child;

  const ShellNavigatorPage({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CollectionModel>>(
      create: (context) => context.read<CollectionProvider>().spotStream,
      initialData: const [],
      child: Scaffold(
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
                _showImageOptions(context);
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
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          minimum: const EdgeInsets.only(bottom: 32),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(L10n.of(context)!.takePhoto),
                  onTap: () async {
                    _takePhoto(imagePicker).then((value) {
                      Navigator.of(context).pop();
                      if (value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(L10n.of(context)!.takePhotoFailed),
                          ),
                        );
                      } else {
                        context.read<CreationProvider>().initializeCreation(value);
                        context.push('/create');
                      }
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(L10n.of(context)!.pickPhoto),
                  onTap: () {
                    _pickImage(imagePicker).then((value) {
                      Navigator.of(context).pop();
                      if (value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(L10n.of(context)!.pickPhotoFailed),
                          ),
                        );
                      } else {
                        context.read<CreationProvider>().initializeCreation(value);
                        context.push('/create');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _pickImage(ImagePicker imagePicker) async {
    PermissionStatus permission = await Permission.photos.request();
    if (permission.isGranted) {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    }
    return null;
  }

  Future<File?> _takePhoto(ImagePicker imagePicker) async {
    PermissionStatus permission = await Permission.camera.request();
    if (permission.isGranted) {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
    }
    return null;
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
