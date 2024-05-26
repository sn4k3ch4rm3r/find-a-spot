import 'package:find_a_spot/features/collection/widgets/collection_card.dart';
import 'package:find_a_spot/features/shell_navigator/models/collection_model.dart';
import 'package:find_a_spot/features/shell_navigator/providers/collection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CollectionModel> spots = context.watch<CollectionProvider>().spots;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.large(
            title: Text(L10n.of(context)!.collection),
            pinned: true,
            stretch: false,
            actions: [
              IconButton(
                onPressed: () {
                  context.push('/profile');
                },
                icon: const Icon(Icons.person),
              ),
            ],
          )
        ],
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: spots.length,
              itemBuilder: (context, index) {
                return CollectionCard(spot: spots[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
