import 'package:flutter/material.dart';

import '../models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  void addEntry(JournalEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void updateEntry(JournalEntry entry) {
    final index = _entries.indexOf(entry);
    if (index != -1) {
      _entries[index] = entry;
      notifyListeners();
    }
  }

  void deleteEntry(JournalEntry entry) {
    _entries.remove(entry);
    notifyListeners();
  }

// ... other methods for favorites, trash, etc.
}