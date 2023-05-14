class NoticeList {
  final String name;
  final List<Notice> notices;

  NoticeList({required this.name, required this.notices});

  factory NoticeList.fromJson(Map<String, dynamic> json) {
    var list = json['alarm'] as List;
    List<Notice> noticeList = list.map((i) => Notice.fromJson(i)).toList();

    return NoticeList(
      name: json['name'],
      notices: noticeList,
    );
  }
}

class Notice {
  final String type;
  final NoticeData data;
  final bool isRead;

  Notice({required this.type, required this.data, required this.isRead});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      type: json['type'],
      data: NoticeData.fromJson(json['data']),
      isRead: json['isRead'],
    );
  }
}

class NoticeData {
  final int id;
  final String title;
  final DateTime createdDate; // Change this line
  final Sender? sender;

  NoticeData(
      {required this.id,
      required this.title,
      required this.createdDate, // And this line
      this.sender});

  factory NoticeData.fromJson(Map<String, dynamic> json) {
    return NoticeData(
      id: json['id'],
      title: json['title'],
      createdDate: DateTime.parse(json['created_date']), // Parse here
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
    );
  }
}

class Sender {
  final int id;
  final String gender;

  Sender({required this.id, required this.gender});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      gender: json['gender'],
    );
  }
}
