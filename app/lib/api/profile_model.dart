class Profile {
  final int userId;
  final String profileImage;
  final String name;
  final int coin;
  final List<MentionedTopic> mostMentionedTopic;
  final int groupCount;
  final int mentionCount;

  Profile.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        profileImage = json['profile_image'],
        name = json['name'],
        coin = json['coin'],
        mostMentionedTopic = (json['most_mentioned_topic'] as List)
            .map((i) => MentionedTopic.fromJson(i))
            .toList(),
        groupCount = json['group_count'],
        mentionCount = json['mention_count'];
}

class MentionedTopic {
  final String title;
  final int mentionedCount;

  MentionedTopic.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        mentionedCount = json['mentioned_count'];
}

class Group {
  final int groupId;
  final String groupImage;
  final String groupName;
  final int groupMember;

  Group.fromJson(Map<String, dynamic> json)
      : groupId = json['group_id'],
        groupImage = json['group_image'],
        groupName = json['group_name'],
        groupMember = json['group_member'];
}

class Mention {
  final int topicId;
  final String topicTitle;
  final Sender sender;
  final String lagdate;
  final int hintStep;

  Mention.fromJson(Map<String, dynamic> json)
      : topicId = json['topic_id'],
        topicTitle = json['topic_title'],
        sender = Sender.fromJson(json['sender']),
        lagdate = json['lagdate'],
        hintStep = json['hint_step'];
}

class Sender {
  final int userId;
  final String gender;

  Sender.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        gender = json['gender'];
}
