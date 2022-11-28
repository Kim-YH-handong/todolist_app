class Todo{
  Todo({
    required this.title,
    required this.memo,
    required this.endDate,
    required this.important,
    required this.isEnd,
    required this.documentId
  });

  final String title;
  final String memo;
  final String endDate;
  bool important;
  final bool isEnd;
  final String documentId;
}