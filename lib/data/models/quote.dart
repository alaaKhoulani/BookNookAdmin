class Quote {
  late int? id;
  late int? userId;
  late String? quote;
  late String? firstName;
  late String? middletName;
  late String? lastName;
  late String? library;
  late int? role_id;
  late String? image;
  Quote(
      {this.id,
      this.firstName,
      this.image,
      this.lastName,
      this.library,
      this.middletName,
      this.quote,
      this.role_id,
      this.userId});
  Quote fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json["quote"],
      userId: json["user_info"]["id"],
      id: json["quote_id"],
      firstName: json["user_info"]["first_name"],
      middletName: json["user_info"]["middle_name"],
      lastName: json["user_info"]["last_name"],
      library: json["user_info"]["library_name"],
      role_id: json["user_info"]["role_id"],
      image: json["user_info"]["image"],
    );
  }
}
