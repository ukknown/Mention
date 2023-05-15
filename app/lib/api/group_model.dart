class Group {
  final int id;
  final String name;
  final String image;
  final int capacity;
  final List<Member> memberList;
  final List<Vote> voteList;

  Group({
    required this.id,
    required this.name,
    required this.image,
    required this.capacity,
    required this.memberList,
    required this.voteList,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    final List<dynamic> membersJson = json['memberList'] ?? [];
    final List<dynamic> votesJson = json['voteList'] ?? [];

    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      capacity: json['capacity'],
      memberList: membersJson.map((member) => Member.fromJson(member)).toList(),
      voteList: votesJson.map((vote) => Vote.fromJson(vote)).toList(),
    );
  }
}

class Member {
  final int memberId;
  final String nickname;
  final String profileImage;

  Member({
    required this.memberId,
    required this.nickname,
    required this.profileImage,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
    );
  }
}

class Vote {
  // Vote 모델의 구성 요소 정의
  // ...

  factory Vote.fromJson(Map<String, dynamic> json) {
    // Vote.fromJson의 내용 정의
    // ...
  }
}
