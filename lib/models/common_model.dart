class Event {
  final String id;
  final String name;
  final Category category;
  final DateTime date;
  final String time;
  final String location;
  final TicketPrices ticketPrices;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String image;
  final String headToHead;

  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.ticketPrices,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.headToHead,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      category: Category.fromJson(json['category']),
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      ticketPrices: TicketPrices.fromJson(json['ticketPrices']),
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      image: json['image'] ?? '',
      headToHead: json['head_to_head'] ?? '',
    );
  }
}

class Category {
  final String id;
  final String name;
  final String image;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class TicketPrices {
  final double tribune;
  final double annexeLoge;
  final double logeVIP;
  final double logeVVIP;
  final double serviceFee;
  final double processingFee;

  TicketPrices({
    required this.tribune,
    required this.annexeLoge,
    required this.logeVIP,
    required this.logeVVIP,
    required this.serviceFee,
    required this.processingFee,
  });

  factory TicketPrices.fromJson(Map<String, dynamic> json) {
    return TicketPrices(
      tribune: (json['tribune']?.toDouble()) ?? 0.0,
      annexeLoge: (json['annexeLoge']?.toDouble()) ?? 0.0,
      logeVIP: (json['logeVIP']?.toDouble()) ?? 0.0,
      logeVVIP: (json['logeVVIP']?.toDouble()) ?? 0.0,
      serviceFee: (json['serviceFee']?.toDouble()) ?? 0.0,
      processingFee: (json['processingFee']?.toDouble()) ?? 0.0,
    );
  }
}

class PaginationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  PaginationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

class CardModel {
  String cardHolderName;
  String cardNumber;
  String expiryMonth;
  String expiryYear;
  String cvv;
  String cardBrand;

  CardModel({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.cardBrand,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardHolderName: json['cardHolderName'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      expiryMonth: json['expiryMonth'] ?? '',
      expiryYear: json['expiryYear'] ?? '',
      cvv: json['cvv'] ?? '',
      cardBrand: json['cardBrand'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'cardBrand': cardBrand,
    };
  }
}
