class TransactionHistory {
  TransactionHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final List<Datum> data;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.transactionId,
    required this.transactionTime,
    required this.transactionType,
    required this.amount,
  });

  final String transactionId;
  final DateTime transactionTime;
  final String transactionType;
  final int amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        transactionId: json["transaction_id"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionType: json["transaction_type"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_type": transactionType,
        "amount": amount,
      };
}
