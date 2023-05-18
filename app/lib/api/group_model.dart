class GroupDetailModel {
  final int id;
  final String name;
  final String image;
  final int capacity;
  final List<MemberModel> memberList;
  final List<VoteModel> voteList;

  GroupDetailModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.capacity,
      required this.memberList,
      required this.voteList});

  factory GroupDetailModel.fromJson(Map<String, dynamic> json) {
    return GroupDetailModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      capacity: json['capacity'],
      memberList: (json['memberList'] as List)
          .map((i) => MemberModel.fromJson(i))
          .toList(),
      voteList:
          (json['voteList'] as List).map((i) => VoteModel.fromJson(i)).toList(),
    );
  }
}

class MemberModel {
  final int memberId;
  final String nickname;
  final String profileImage;

  MemberModel(
      {required this.memberId,
      required this.nickname,
      required this.profileImage});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      memberId: json['memberId'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
    );
  }
}

class VoteModel {
  final int voteId;
  final String topicTitle;
  final int emoji;
  final String dueDate;
  final int participant;
  final bool system;

  VoteModel(
      {required this.voteId,
      required this.topicTitle,
      required this.emoji,
      required this.dueDate,
      required this.participant,
      required this.system});

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      voteId: json['voteId'],
      topicTitle: json['topicTitle'],
      emoji: int.tryParse(json['emoji'] ?? '', radix: 16) ??
          int.parse('1F60B', radix: 16),
      dueDate: json['dueDate'],
      participant: json['participant'],
      system: json['isSystem'],
    );
  }
}
