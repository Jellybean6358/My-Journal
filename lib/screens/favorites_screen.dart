import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../widgets/journal_entry_grid_tile.dart';
import '../models/journal_entry.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);
    final favoriteEntries =
    journalProvider.entries.where((entry) => entry.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: favoriteEntries.length,
        itemBuilder: (context, index) {
          final entry = favoriteEntries[index];
          return JournalEntryGridTile(entry: entry);
        },
      ),
    );
  }
}