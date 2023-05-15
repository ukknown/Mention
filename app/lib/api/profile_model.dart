import 'dart:ffi';

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
  final Long? mentionId;
  final String? topicTitle;
  final int hintStep;
  final String gender;
  final int emoji;

  Mention.fromJson(Map<String, dynamic> json)
      : mentionId = json['mentionId'] as Long?,
        topicTitle = json['topicTitle'] as String?,
        hintStep = json['hintStatus'] ?? 0,
        gender = json['voterGender'] ?? 'unknown',
        emoji = int.tryParse(json['emoji'] ?? '', radix: 16) ?? int.parse('1F60B', radix: 16);
}