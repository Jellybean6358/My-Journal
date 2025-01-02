import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/journal_entry.dart';

import 'providers/journal_provider.dart';
import 'animated_screens/welcome_animate.dart';
import 'screens/trash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => JournalProvider(),
      //debugShowCheckedModeBanner: false,
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const WelcomeAnimateScreen(),
    );
  }
}


/*import 'package:flutter/material.dart';
//import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(JournalApp());
}
class JournalModel extends ChangeNotifier {
  final List<String> _entries = [
    "Entry 1: This is the first entry in my journal.",
    "Entry 2: This is the second entry.",
    "Entry 3: This is a longer entry with more details.",
    "Entry 4: This is a favorite entry.",
    "Entry 5: Another entry for the journal.",
  ];
  final List<String> _favoriteEntries = ["Entry 4"];
  String _searchText = "";

  List<String> get entries => _entries;
  List<String> get favoriteEntries => _favoriteEntries;
  String get searchText => _searchText;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}

class JournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JournalModel(),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journalModel = Provider.of<JournalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journal'),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _offsetAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: _offsetAnimation.value,
                child: child,
              );
            },
            child: const Center(
              child: Text(
                'Welcome to Your Journal',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      journalModel.setSearchText(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search entries',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        //mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      itemCount: journalModel.entries
                          .where((entry) => entry
                          .toLowerCase()
                          .contains(journalModel.searchText.toLowerCase()))
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        final filteredEntries = journalModel.entries
                            .where((entry) => entry
                            .toLowerCase()
                            .contains(journalModel.searchText.toLowerCase()))
                            .toList();
                        final entry = filteredEntries[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(entry),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          );
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final journalModel = Provider.of<JournalModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: journalModel.favoriteEntries.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(journalModel.favoriteEntries[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

 */