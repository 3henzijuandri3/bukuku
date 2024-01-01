class ListBookModel {
  List<BookModel?>? data;
  int? total;

  ListBookModel({
    required this.data,
    required this.total,
  });

  factory ListBookModel.fromJson(Map<String, dynamic> json) {
    return ListBookModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((book) => BookModel.fromJson(book))
          .toList(),
      total: json['total'],
    );
  }
}

class AddBookResponse {
  String? message;
  BookModel? book;

  AddBookResponse({this.message, this.book});

  factory AddBookResponse.fromJson(Map<String, dynamic> json) {
    return AddBookResponse(
      message: json['message'],
      book: json['book'] != null ? BookModel.fromJson(json['book']) : null,
    );
  }
}

class BookModel {
  int? id;
  int? userId;
  String? isbn;
  String? title;
  String? subtitle;
  String? author;
  String? published;
  String? publisher;
  int? pages;
  String? description;
  String? website;
  String? createdAt;
  String? updatedAt;

  BookModel({
    this.id,
    this.userId,
    this.isbn,
    this.title,
    this.subtitle,
    this.author,
    this.published,
    this.publisher,
    this.pages,
    this.description,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      userId: json['user_id'],
      isbn: json['isbn'],
      title: json['title'],
      subtitle: json['subtitle'],
      author: json['author'],
      published: json['published'],
      publisher: json['publisher'],
      pages: json['pages'],
      description: json['description'],
      website: json['website'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'isbn': isbn,
      'title': title,
      'subtitle': subtitle,
      'author': author,
      'published': published,
      'publisher': publisher,
      'pages': pages,
      'description': description,
      'website': website,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}