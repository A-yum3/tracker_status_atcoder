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
  String lastUpdateData;

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
      this.imageUrl,
      this.lastUpdateData});

  @override
  bool operator ==(Object other) => other is User && other.userId == userId;

  @override
  int get hashCode => userId.hashCode;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['user_id'] = userId;
    map['accepted_count'] = acceptedCount;
    map['rated_point_sum'] = ratedPointSum;
    map['accepted_count_rank'] = acceptedCountRank;
    map['rated_point_sum_rank'] = ratedPointSumRank;
    map['affiliation'] = affiliation;
    map['birth_year'] = birthYear;
    map['competitions'] = competitions;
    map['formal_country_name'] = formalCountryName;
    map['highest_rating'] = highestRating;
    map['rank_atcoder'] = rank;
    map['rating'] = rating;
    map['last_update'] = lastUpdate;
    map['color'] = color;
    map['image_url'] = imageUrl;
    map['last_update_data'] = lastUpdateData;

    return map;
  }

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
      rank: json['rank'] ??= json['rank_atcoder'],
      rating: json['rating'],
      lastUpdate: json['updated'] ??= json['last_update'],
      color: json['user_color'] ??= json['color'],
      imageUrl: json['image_url'],
      lastUpdateData: json['last_update_data'],
    );
  }
}
