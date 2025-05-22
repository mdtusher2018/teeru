class ReviewResponse {
  final bool success;
  final int statusCode;
  final String message;
  final Review data;

  ReviewResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: Review.fromJson(json['data']),
    );
  }
}

class Review {
  final String userId;
  final double rating;
  final String comment;
  final bool isDeleted;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  Review({
    required this.userId,
    required this.rating,
    required this.comment,
    required this.isDeleted,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'] ?? '',
      rating: (json['rating'] != null) ? json['rating'].toDouble() : 0.0,
      comment: json['comment'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
