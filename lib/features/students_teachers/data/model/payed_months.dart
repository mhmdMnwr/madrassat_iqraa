class PayedMonths {
  final String studentId;
  final DateTime payedDates;
  final int amount;

  PayedMonths({
    required this.amount,
    required this.studentId,
    DateTime? payedDates,
  }) : payedDates = payedDates ?? DateTime.now();

  factory PayedMonths.fromJson(Map<String, dynamic> json) {
    return PayedMonths(
      amount: json['amount'] as int,
      studentId: json['studentId'],
      payedDates: DateTime.parse(json['payedDates'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'payedDates': payedDates.toIso8601String(),
      'amount': amount,
    };
  }
}
