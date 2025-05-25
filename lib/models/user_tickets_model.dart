import 'package:trreu/models/common_model.dart';

class UserTicketsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<UserTicket> data;

  UserTicketsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UserTicketsResponse.fromJson(Map<String, dynamic> json) {
    return UserTicketsResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List).map((e) => UserTicket.fromJson(e)).toList(),
    );
  }
}

class UserTicket {
  final String id;
  final String userId;
  final Event event;
  final Payment payment;
  final List<TicketInfo> tickets;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserTicket({
    required this.id,
    required this.userId,
    required this.event,
    required this.payment,
    required this.tickets,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserTicket.fromJson(Map<String, dynamic> json) {
    return UserTicket(
      id: json['_id'],
      userId: json['userId'],
      event: Event.fromJson(json['eventId']),
      payment: Payment.fromJson(json['paymentId']),
      tickets:
          (json['tickets'] as List).map((e) => TicketInfo.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Payment {
  final String id;
  final String userId;
  final int amount;
  final String paymentStatus;
  final String transactionId;
  final String paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String ticketId;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.paymentStatus,
    required this.transactionId,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.ticketId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'],
      userId: json['user_id'],
      amount: json['amount'],
      paymentStatus: json['paymentStatus'],
      transactionId: json['transactionId'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      ticketId: json['ticketId'],
    );
  }
}

class TicketInfo {
  final String type;
  final int seat;

  TicketInfo({required this.type, required this.seat});

  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    return TicketInfo(type: json['type'], seat: json['seat']);
  }
}
