class Profile {
  final String? profileImage;
  final String name;
  final int coin;
  final List<MentionedTopic> mostMentionedTopic;
  final int groupCount;
  final int mentionCount;

  Profile.fromJson(Map<String, dynamic> json)
      : profileImage = json['profileImage'] as String?,
        name = json['nickname'] ?? 'unknown',
        coin = json['bangAmount'] ?? 0,
        mostMentionedTopic = _ensureThreeTopics(json['topTopic']),
        groupCount = json['groupCount'] ?? 0,
        mentionCount = json['mentionCount'] ?? 0;

  static List<MentionedTopic> _ensureThreeTopics(List<dynamic>? topicsJson) {
    if (topicsJson == null) {
      return List<MentionedTopic>.filled(
        3,
        MentionedTopic(
          title: '멘션받은 토픽이 없어요!',
          mentionedCount: 0,
        ),
      );
    }

    var topics = topicsJson.map((i) => MentionedTopic.fromJson(i)).toList();

    while (topics.length < 3) {
      topics.add(
        MentionedTopic(
          title: '멘션받은 토픽이 없어요!',
          mentionedCount: 0,
        ),
      );
    }

    return topics;
  }
}

class MentionedTopic {
  final String? title;
  final int mentionedCount;

  MentionedTopic({this.title, this.mentionedCount = 0});

  MentionedTopic.fromJson(Map<String, dynamic> json)
      : title = json['topicTitle'] as String?,
        mentionedCount = json['mentionCount'] ?? 0;
}

class Group {
  final int? groupId;
  final String? groupImage;
  final String groupName;
  final int groupMember;

  Group.fromJson(Map<String, dynamic> json)
      : groupId = json['id'] as int?,
        groupImage = json['image'] as String?,
        groupName = json['name'] ?? 'unknown',
        groupMember = json['capacity'] ?? 0;
}

class Mention {
  final int? topicId;
  final String? topicTitle;
  final Sender sender;
  final DateTime? regdate;
  final int hintStep;

  Mention.fromJson(Map<String, dynamic> json)
      : topicId = json['topic_id'] as int?,
        topicTitle = json['topic_title'] as String?,
        sender = Sender.fromJson(json['sender']),
        regdate = json['regdate'] as DateTime?,
        hintStep = json['hint_step'] ?? 0;
}

class Sender {
  final int? userId;
  final String gender;

  Sender.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as int?,
        gender = json['gender'] ?? 'unknown';
}
