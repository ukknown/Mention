class Notice {
  final int noticeId;
  final String? noticeType;
  final int routingId;
  final DateTime regDate;
  final String noticeTitle;
  final String targetTitle;
  final String gender;

  Notice.fromJson(Map<String, dynamic> json)
      : noticeId = json['id'],
        noticeType = json['type'] as String?,
        routingId = json['routingId'] ?? -1,
        regDate = DateTime.parse(json['regDate'].toString()),
        gender = json['gender'] ?? 'unknown',
        noticeTitle = _getNoticeTitle(json['title']),
        targetTitle = _getTargetTitle(json['title']);
  
  static String _getNoticeTitle(String? inputTitle) {
    if (inputTitle == null) {
      return '';
    }
    List<String> parts = inputTitle.split('*');
    return parts[0];
  }

  static String _getTargetTitle(String? inputTitle) {
    if (inputTitle == null) {
      return '';
    }
    List<String> parts = inputTitle.split('*');
    return parts.length > 1 ? parts[1] : '';
  }
}
