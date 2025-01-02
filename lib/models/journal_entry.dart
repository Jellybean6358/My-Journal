class JournalEntry {
  final String title;
  final String content;
  final DateTime date;
  bool isFavorite;
  bool isDeleted;

  JournalEntry({
    required this.title,
    required this.content,
    required this.date,
    this.isFavorite = false,
    this.isDeleted = false,
  });
}