class User {
  String userId;
  int acceptedCount;
  double ratedPointSum;
  int acceptedCountRank;
  int ratedPointSumRank;
  String affiliation;
  int birthYear;
  int competitions;
  String formalCountryName;
  int highestRating;
  int rank;
  int rating;
  dynamic lastUpdate;
  String color;
  String imageUrl;

  User(
      {this.userId,
      this.acceptedCount,
      this.ratedPointSum,
      this.acceptedCountRank,
      this.ratedPointSumRank,
      this.affiliation,
      this.birthYear,
      this.competitions,
      this.formalCountryName,
      this.highestRating,
      this.rank,
      this.rating,
      this.lastUpdate,
      this.color,
      this.imageUrl});

  @override
  bool operator ==(Object other) => other is User && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      acceptedCount: json['accepted_count'],
      ratedPointSum: json['rated_point_sum'],
      acceptedCountRank: json['accepted_count_rank'],
      ratedPointSumRank: json['rated_point_sum_rank'],
      affiliation: json['affiliation'],
      birthYear: json['birth_year'],
      competitions: json['competitions'],
      formalCountryName: json['formal_country_name'],
      highestRating: json['highest_rating'],
      rank: json['rank'],
      rating: json['rating'],
      lastUpdate: json['updated'],
      color: json['user_color'],
      imageUrl: json['image_url'],
    );
  }
}
