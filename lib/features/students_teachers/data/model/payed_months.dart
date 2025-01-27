class PayedMonths {
  final String studentId;
  final DateTime payedDates;

  PayedMonths({
    required this.studentId,
    DateTime? payedDates,
  }) : payedDates = DateTime.now();

  factory PayedMonths.fromJson(Map<String, dynamic> json) {
    return PayedMonths(
      studentId: json['studentId'],
      payedDates: json['payedDates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'payedDates': payedDates,
    };
  }
}
