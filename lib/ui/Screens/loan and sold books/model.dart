class Borrowed {
  late int? id;
  late String? userfirstname;
  late String? userlastname;
  late BookItem? book;
  late int? remainingdays;
  Borrowed(
      {this.book,
      this.remainingdays,
      this.userfirstname,
      this.userlastname,
      this.id});

  Borrowed fromJson1(Map<String, dynamic> json) {
    // print("fromjsonbook");
    // print(json["categories"]);

    return Borrowed(
      id: json["borrow_id"],
      userfirstname: json['user']["first_name"],
      userlastname: json['user']["last_name"],
      book: BookItem().fromJson1(json['book']),
      remainingdays: json['remaining days'],
    );
  }
}

class BookItem {
  late int? bookId;
  late int? id;
  late Library? library;
  late String? name;
  late int? numOfPage;
  late String? summary;
  late String? pdf;
  late String? image;
  late int? searches;
  late int? rate;
  late List<Category>? categories;
  late List<Author>? authors;
  late int? purchasingPrice;
  late int? sellingPrice;
  late String? state;
  late int? quantity;
  late String? createdAt;
  late String? updatedAt;
  late String? deletedAt;
  // late int? remainingdays;

  BookItem({
    this.id,
    this.bookId,
    this.library,
    this.name,
    this.numOfPage,
    this.summary,
    this.pdf,
    this.image,
    this.searches,
    this.rate,
    this.categories,
    this.authors,
    this.purchasingPrice,
    this.sellingPrice,
    this.state,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    //this.remainingdays
  });

  BookItem fromJson1(Map<String, dynamic> json) {
    // print("fromjsonbook");
    // print(json["categories"]);
    late BookItem book;
    return BookItem(
      id: json['id'],
      bookId: json['book_id'],
      name: json['name'],
      summary: json['summary'],
      pdf: json['pdf'],
      image: json['image'],
      searches: json['searches'],
      rate: json['rate'],
      purchasingPrice: json['purchasing_price'],
      sellingPrice: json['selling_price'],
      state: json['state'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      numOfPage: json['num_of_page'],
      categories: Category().arrayFromJson1(json["categories"]),
      authors: Author().arrayFromJson1(json["authors"]),
      // remainingdays: json["remaining days"]
      // authors:
    );
  }

  static List<BookItem> fromJsonList(Map<String, dynamic> json) {
    // print("list books");
    // print(json);
    List<BookItem> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(BookItem().fromJson1(json[i]));
    }
    return _list;
  }
}

class Library {
  late int id;
  late int roleId;
  late String email;
  late int isVerified;
  late String firstName;
  late String middleName;
  late String lastName;
  late String? libraryName;
  late int phoneNumber;
  late String image;
  late String status;
  late String openTime;
  late String closeTime;
  late String createdAt;
  late String updatedAt;

  Library(
      {required this.id,
      required this.roleId,
      required this.email,
      required this.isVerified,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.libraryName,
      required this.phoneNumber,
      required this.image,
      required this.status,
      required this.openTime,
      required this.closeTime,
      required this.createdAt,
      required this.updatedAt});

  Library.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    email = json['email'];
    isVerified = json['is_verified'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    libraryName = json['library_name'];
    phoneNumber = json['phone_number'];
    image = json['image'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['email'] = this.email;
    data['is_verified'] = this.isVerified;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['library_name'] = this.libraryName;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['status'] = this.status;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});
  List<Category> arrayFromJson1(List json) {
    // print("json category");
    // print(json);
    List<Category> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(Category().fromJson1(json[i]));
    }
    return _list;
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Category fromJson1(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Author {
  int? id;
  String? name;

  Author({this.id, this.name});
  Author fromJson1(Map<String, dynamic> json) {
    return Author(id: json["id"], name: json["name"]);
  }

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  List<Author> arrayFromJson1(List json) {
    // print("json author");
    // print(json);
    List<Author> _list = [];
    for (var i = 0; i < json.length; i++) {
      _list.add(Author().fromJson1(json[i]));
    }
    return _list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
