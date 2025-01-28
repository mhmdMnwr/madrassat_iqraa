import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/helper/id_generator.dart';

class Transactions extends Equatable {
  final String userName;
  final bool type; // true for income, false for expense
  final int amount; // amount of the transaction
  final String description; // description of the transaction
  final DateTime createdAt; // timestamp of when the transaction was created
  final String id;

  Transactions({
    String? id,
    required this.type,
    required this.userName,
    required this.amount,
    required this.description,
    DateTime? createdAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        id = id ?? IdGenerator.generateId();

  @override
  List<Object?> get props => [type, amount, description, createdAt, userName];

  // Factory constructor to create a Transaction instance from JSON
  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      id: json['id'] as String,
      type: json['type'] as bool,
      amount: json['amount'] as int,
      description: json['description'] as String,
      userName: json['userName'] as String,
      // Parse createdAt from String to DateTime
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Method to convert a Transaction instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'userName': userName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
