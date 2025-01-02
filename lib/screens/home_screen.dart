import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/trash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/add_screen.dart';

import '../models/journal_entry.dart';

import '../providers/journal_provider.dart';

import '../widgets/journal_entry_grid_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool _showSearchBar = false;
  bool _isGLay = true;

  // late AnimationController _animationController;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        //_showSearchBar = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    //_animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final journalProvider = Provider.of<JournalProvider>(context);
    final entries = journalProvider.entries
        .where((entry) =>
            entry.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          'My Journal✍️',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGLay = !_isGLay;
              });
            },
            icon: Icon(
              _isGLay ? Icons.view_list : Icons.grid_on,
              color: theme.colorScheme.onSurface,
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: '1',
                child: Text('Dark theme'),
              ),
              const PopupMenuItem<String>(
                value: '2',
                child: Text('Null'),
              ),
              const PopupMenuItem<String>(
                value: '3',
                child: Text('Layout'),
              ),
              const PopupMenuItem<String>(
                value: '4',
                child: Text('Refresh🔁'),
              ),
            ],
            onSelected: (value) {
              print('Selected:$value');
              switch(value){
                case '1':break;
                case '2':break;
                case '3':setState(() {
                  _isGLay = !_isGLay;
                });
                  break;
                case '4':break;
                default:break;
              }
            },
            icon: Icon(
              Icons.settings,
              color: theme.colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {
              print('Refreshingggggg!!!!...');
              //journalProvider.fetchData();
            },
            icon: Icon(
              Icons.refresh,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _isGLay
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return JournalEntryGridTile(entry: entry);
                  },
                )
              : ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return JournalEntryGridTile(entry: entry);
                  },
                ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                elevation: 10.0,
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search your dayys!',
                      prefix: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      //border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewEntryScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrashScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )),
    );
  }
}
