class User {
  String userId;
  int acceptedCount;
  double ratedPointSum;
  int acceptedCountRank;
  int ratedPointSumRank;

  User(
      {this.userId,
      this.acceptedCount,
      this.ratedPointSum,
      this.acceptedCountRank,
      this.ratedPointSumRank});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      acceptedCount: json['accepted_count'],
      ratedPointSum: json['rated_point_sum'],
      acceptedCountRank: json['accepted_count_rank'],
      ratedPointSumRank: json['rated_point_sum_rank'],
    );
  }
}
