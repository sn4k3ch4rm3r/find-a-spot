import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CreatePage extends StatelessWidget {
  final Image image;
  const CreatePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.create),
      ),
      body: Center(
        child: image,
      ),
    );
  }
}
