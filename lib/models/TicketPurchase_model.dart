class TicketPurchaseResponse {
  bool success;
  int statusCode;
  String message;
  TicketPurchaseData data;

  TicketPurchaseResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TicketPurchaseResponse.fromJson(Map<String, dynamic> json) =>
      TicketPurchaseResponse(
        success: json['success'],
        statusCode: json['statusCode'],
        message: json['message'],
        data: TicketPurchaseData.fromJson(json['data']),
      );
}

class TicketPurchaseData {
  String userId;
  String eventId;
  String paymentId;
  List<Ticket> tickets;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  TicketPurchaseData({
    required this.userId,
    required this.eventId,
    required this.paymentId,
    required this.tickets,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TicketPurchaseData.fromJson(Map<String, dynamic> json) =>
      TicketPurchaseData(
        userId: json['userId'],
        eventId: json['eventId'],
        paymentId: json['paymentId'],
        tickets: List<Ticket>.from(
          json['tickets'].map((x) => Ticket.fromJson(x)),
        ),
        id: json['_id'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        v: json['__v'],
      );
}

class Ticket {
  String type;
  int seat;

  Ticket({required this.type, required this.seat});

  factory Ticket.fromJson(Map<String, dynamic> json) =>
      Ticket(type: json['type'], seat: json['seat']);
}
