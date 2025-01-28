class PayedMonths {
  final String studentId;
  final DateTime payedDates;

  PayedMonths({
    required this.studentId,
    DateTime? payedDates,
  }) : payedDates = payedDates ?? DateTime.now();

  factory PayedMonths.fromJson(Map<String, dynamic> json) {
    return PayedMonths(
      studentId: json['studentId'],
      payedDates: DateTime.parse(json['payedDates'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'payedDates': payedDates.toIso8601String(),
    };
  }
}
