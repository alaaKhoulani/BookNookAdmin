class Address {
  int? id;
  int? userId;
  String? title;
  String? area;
  String? street;
  int? floor;
  String? near;
  String? details;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
      this.userId,
      this.title,
      this.area,
      this.street,
      this.floor,
      this.near,
      this.details,
      this.createdAt,
      this.updatedAt});

  Address fromJson(Map<String, dynamic> json) {
    Address addresss = Address(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      area: json['area'],
      street: json['street'],
      floor: json['floor'],
      near: json['near'],
      details:json['details'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
    // if (json['details'] != null)
    //   details = json['details'];
    // else
    //   details = ' ';
    return addresss;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['area'] = this.area;
    data['street'] = this.street;
    data['floor'] = this.floor;
    data['near'] = this.near;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
