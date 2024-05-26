import 'package:flutter/material.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -18),
      child: const Icon(
        Icons.location_on,
        size: 36,
        color: Colors.red,
      ),
    );
  }
}
