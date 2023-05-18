class SearchTopic {
  final int id;
  final String title;
  final int emoji;

  SearchTopic({
    required this.id,
    required this.title,
    required this.emoji,
  });

  SearchTopic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        emoji = int.tryParse(json['emoji'] ?? '', radix: 16) ??
            int.parse('1F60B', radix: 16);
}

class TopicRandom {
  final int id;
  final String title;
  final int emoji;

  TopicRandom.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        emoji = int.tryParse(json['emoji'] ?? '', radix: 16) ??
            int.parse('1F60B', radix: 16);

  SearchTopic toSearchTopic() {
    return SearchTopic(
      id: this.id,
      title: this.title,
      emoji: this.emoji,
    );
  }
}
