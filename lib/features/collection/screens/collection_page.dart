import 'package:find_a_spot/features/collection/widgets/collection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CollectionCard(imgUrl: 'https://picsum.photos/800')),
            SliverToBoxAdapter(child: CollectionCard(imgUrl: 'https://picsum.photos/801')),
            SliverToBoxAdapter(child: CollectionCard(imgUrl: 'https://picsum.photos/802')),
            SliverToBoxAdapter(child: CollectionCard(imgUrl: 'https://picsum.photos/803')),
            SliverToBoxAdapter(child: CollectionCard(imgUrl: 'https://picsum.photos/804')),
          ],
        ),
      ),
    );
  }
}
